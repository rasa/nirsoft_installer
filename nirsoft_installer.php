<?php

/*
todo if $ext <> zip then use 
downloadGUIEXE 
or downloadCLIEXE

use curl to get mod date and length headers, then download if different?
*/

$base = 'http://www.nirsoft.net';
$subdir = '/utils';
$root = 'd:/nirsoft';
$dir = $root . '/www.nirsoft.net';
$dest_root = $root . '/nsis';
$scandir = $dir . $subdir;
$files = array();

@mkdir($dest_root);

$get = array(
	'zip'	=> '',
	'exe'	=> '',
	'scr'	=> '',
);

$skip = array(
	'_setup',
	'arabic',
	'brazilian',
	'bulgarian',
	'chinese',
	'croatian',
	'czech',
	'danish',
	'dutch',
	'estonian',
	'finnish',
	'french',
	'galician',
	'ge_old_style',
	'german',
	'greek',
	'hebrew',
	'hungarian',
	'italian',
	'japanese',
	'korean',
	'norwegian',
	'persian',
	'polish',
	'portuguese',
	'romanian',
	'russian',
	'serbian',
	'slovak',
	'slovenian',
	'spanish',
	'swedish',
	'taiwanese',
	'turkish',
	'ukrainian',
	'valencian',
);

function dump_nodes($file, $node) {
	global $files;
	global $base;
	global $subdir;
	global $get;
	global $dest_dir;
	global $skip;
	
	if (!$node->hasChildren())
		return;
	
	foreach ($node->child as $child) {
		if (isset($child->id) && $child->id == TIDY_TAG_A) {
			$url = @$child->attribute['href'];
			if (!$url)
				continue;
			if (strstr($url, ':') === false) {
				if (substr($url, 0, 1) <> '/')
					$url = $base . $subdir . '/' . $url;
				else
					$url = $base . $url;
#printf("url=%s\n", $url);				
			}
			$a = parse_url($url);
			if (!$a)
				continue;
			if (@$a['scheme'] != 'http')
				continue;
			if (@$a['query'])
				continue;
			if (@$a['fragment'])
				continue;
			$b = pathinfo(@$a['path']);
			if (!$b)
				continue;
			$e = strtolower(@$b['extension']);
			
			if (!$e)
				continue;
			if (!isset($get[$e]))
				continue;
			$found = 0;
			foreach ($skip as $regex) {
				if (preg_match('/' . $regex . '/i', $b['basename'])) {
					$found = 1;
					break;
				}
			}
			if ($found > 0)
				continue;
				
			$key = strtolower(basename($url));
			$files[$key] = array(
				'url'		=> $url,
				'referer'	=> $file
			);
		}
		dump_nodes($file, $child);
	}
}

$a = scandir($scandir);

foreach($a as $file) {
	if (!preg_match('/\.html?/i', $file))
		continue;

	$tidy = tidy_parse_file($scandir . '/' . $file);

	dump_nodes($scandir . $file, $tidy->root());
}

$len = strlen($base) + 1;

ksort($files);

foreach($files as $key => $value) {
	$url = $value['url'];
	$referer = $value['referer'];
	
#printf("url=%s, key=%s\n", $url, $key);

	$file = substr($url, $len);
#printf("file=%s\n", $file);
#exit;

	$zip = $dir . '/' . $file;
#printf("zip=%s\n", $zip);
	if (!file_exists($zip)) {
		fprintf(STDERR, "File not found: %s\n", $zip);
		continue;
	}
	$pathinfo = pathinfo($zip);
	if (!$pathinfo)
		continue;
#print "pathinfo=";
#print_r($pathinfo);

	$ext = $pathinfo['extension'];
	$basename = basename($pathinfo['basename'], '.' . $ext);
	$dest_dir = $dest_root . '/' . $basename;
#printf("dest_dir=%s\n", $dest_dir);
	if (!is_dir($dest_dir)) {
		if (!mkdir($dest_dir))
			die(sprintf("Cannot create directory '%s': %s", $dest_dir, @$phperror_msg));
	}
	
	if (strtolower($ext) <> 'zip') {
		$dst = $dest_dir . '/' . $pathinfo['basename'];
		if (!@copy($zip, $dst)) {
			die(sprintf("Cannot copy '%s' to '%s': %s", $zip, $dst, @$phperror_msg));
		}
	} else {
		$cmd = sprintf('C:/Progra~1/7-Zip/7z.exe x -y -o"%s" "%s"', $dest_dir, $zip);
		exec($cmd, $output, $rv);
		if ($rv <> 0) {
			fprintf(STDERR, "Error %d executing '%s':\n", $rv, $cmd);
			fprintf(STDERR, join("\n", $output));
			exit;
		}
	}
	$exes = glob($dest_dir . '/*.[Ee][Xx][Ee]');
	$scrs = glob($dest_dir . '/*.[Ss][Cc][Rr]');
	$exes = array_merge($exes, $scrs);
	if (count($exes) == 0) {
		fprintf(STDERR, "%d exes found in %s\n", count($exes), $dest_dir);
		continue;
	}
	$macros = Array();
	$md5s = Array();
	$hash = Array();
	foreach($exes as $exe) {
		$md5 = md5_file($zip);
		if (isset($md5s[$md5])) {
			fprintf(STDERR, "Duplicate md5: %s\n", $exe);
			continue;
		}
		$md5s[$md5] = $exe;
		$exebase = basename($exe);

		$cmd = 'exetype -q ' . $exe;
		exec($cmd, $output, $exetype);

		$cmd = sprintf('sigcheck.exe "%s"', $exe);
		exec($cmd, $output, $rv);
		if ($rv <> 0) {
			fprintf(STDERR, "Error %d running '%s'\n", $rv, $cmd);
			fprintf(STDERR, join("\n", $output));
			exit;
		}

		$desc = '';
		$prod = '';

		foreach ($output as $o) {
			if (preg_match('/Description:\s*(.*)$/i', $o, $matches)) {
				$desc = trim($matches[1]);
			}
			if (preg_match('/Product:\s*(.*)$/i', $o, $matches)) {
				$prod = trim($matches[1]);
			}
		}
		$name = $desc;
		if ($desc == '' || $desc == 'n/a')
			$name = $prod;
		if ($name == '' || $name == 'n/a')
			$name = $basename;
		if (stristr($name, $basename) === false)
			$name = $basename . ': ' . $name;
		#printf("%-20s %s (%s %s)\n", trim($b), $name, $desc, $prod);
		if (substr($referer, 0, strlen($dir)) == $dir) {
			$referer = $base . substr($referer, strlen($dir), 255);
		}
		$size = filesize($zip);
		switch (strtolower($ext)) {
			case 'exe':
				$hash[$exetype] = sprintf('!insertmacro DownloadEXE 2 "%s"	"%s"	""	"%s"	"%s"	# %s' . "\n", $name, $url, $size, $md5, $referer);
				break;
			case 'zip':
				switch ($exetype) {
					case 2:
						if (isset($hash[$exetype])) {
							fprintf(STDERR, "Extra GUI %s found in %s\n", $exe, $dest_dir);
							continue;
						}
						$hash[$exetype] = sprintf('!insertmacro DownloadGUI 2 "%s"	"%s"	"%s"	"%s"	""	# "%s" %s' . "\n", $name, $url, $exebase, $size, $md5, $referer);
						break;
					case 3:
						if (isset($hash[$exetype])) {
							fprintf(STDERR, "Extra CLI %s found in %s\n", $exe, $dest_dir);
							continue;
						}
						$hash[$exetype] = sprintf('!insertmacro DownloadCLI 2 "%s"	"%s"	"%s"	"%s"	# "%s" %s' . "\n", $name, $url, $exebase, $size, $md5, $referer);
						break;
					default:
						fprintf(STDERR, "exetype=%s for %s\n", $exetype, $exe);
						$hash[1] = sprintf('#!insertmacro DownloadCLI 2 "%s"	"%s"	"%s"	"%s"	# "%s" %s' . "\n", $name, $url, $exebase, $size, $md5, $referer);
						break;
				}
				break;
		}
	}
	if (isset($hash[3])) {
		print($hash[3]);
		continue;
	}
	if (isset($hash[2])) {
		print($hash[2]);
		continue;
	}
	if (isset($hash[1])) {
		print($hash[1]);
		continue;
	}
}

?>

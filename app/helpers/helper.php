<?php

/*
 * Prints human-readable information a variable
 */

function show($var, $var_dump = false)
{
	echo '<pre>';

	if ($var_dump) {
		var_dump($var);
	} else {
		print_r($var);
	}

	echo '</pre>';
}


/*
 * Returns base URL with the contenated path
 */

function url(string $path)
{
	global $ci;
	$baseUrl = $ci->request->getUri()->getBaseUrl();
	return "$baseUrl$path";
}


/*
 * Returns config from container
 */

function config(string $name)
{
	global $ci;
	$keys = explode('.', $name);
	$temp = $ci;

	foreach ($keys as $key) {
		$temp = $temp[$key];
	}

	return $temp;
}


/*
 * Set or unset a cookie
 */

function cookie(string $name, string $val = null, int $min = 0, string $path = '/')
{
	if ($val !== null || $min < 0) {
		$expiry = $min != 0 ? (time() + (60 * $min)) : 0;		
		setcookie($name, $val, $expiry, $path);
		return;
	}

	return isset($_COOKIE[$name]) ? $_COOKIE[$name] : null;
}


/*
 * Encrypt string using openssl_encrypt
 */

function encrypt(string $plainText)
{
	if (!file_exists('../app/private/encryption_key')) {
	    // generate encryption key
	    $key = random_bytes(32);
	    file_put_contents('../app/private/encryption_key', $key);
	} else {
	    // get encryption key
		$key = file_get_contents('../app/private/encryption_key');
		
		// or generate encryption key if file is empty
		if ($key === false || ($key = trim($key, ' ')) == '') {
			$key = random_bytes(32);
	    	file_put_contents('../app/private/encryption_key', $key);
		}
	}

	// generate nonce
	$encryptMethod = 'AES-256-CBC';
	$nonceSize = openssl_cipher_iv_length($encryptMethod);
	$nonce = openssl_random_pseudo_bytes($nonceSize);

	// encrypt plain text
	$cipherText = openssl_encrypt($plainText, $encryptMethod, $key, 0, $nonce);
	return base64_encode($nonce.$cipherText);
}


/*
 * Decrypt string using openssl_decrypt
 */

function decrypt(string $cipherText)
{
	// get private key
	if (($key = file_get_contents('../app/private/encryption_key')) === false) {
		return false;
	}

	// decode and separate iv from cipherText
	$encryptMethod = 'AES-256-CBC';
	$decoded = base64_decode($cipherText);
	$nonceSize = openssl_cipher_iv_length($encryptMethod);
	$nonce = mb_substr($decoded, 0, $nonceSize, '8bit');
	$cipherText = mb_substr($decoded, $nonceSize, null, '8bit');
	
	// decrypt cipher text	
	return openssl_decrypt($cipherText, $encryptMethod, $key, 0, $nonce);
}


/*
 * Formats a name
 */

function formatName(string $fname, string $mname, string $lname)
{
	$fullname = trim($fname).' ';

	if (trim($mname) != '') {
		$fullname .= strtoupper($mname[0]).'. ';
	}

	$fullname .= trim($lname);
	return $fullname;
}


/*
 * Calculates age
 */

function calcAge(string $bdate)
{
	return \DateTime::createFromFormat('Y-m-d', $bdate)->diff(new \DateTime('now'))->y;
}


/*
 * Returns photo url
 */

function getPhoto(string $path = null)
{
	if (empty($path) || !file_exists("../app/$path")) {
		return url('/assets/img/icon_user.png');
	}

	return url("/assets/$path");
}


/*
 * Check string for password criteria
 */

function validPass(string $str)
{
	return (strlen($str) > 7 && preg_match('/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[~!@#$%^&*()_+)]).*/', $str) === 1);
}


/*
 * Check string if email
 */

function isEmail(string $str)
{
	return preg_match('/^\S+@\S+\.\S+/', $str) === 1;
}


/*
 * Returns pagination buttons
 */

function getPagination(int $itemCount, int $page)
{
	$itemPerPage = 10;
	$btnPerPage = 5;
	$btnCount = ceil($itemCount / $itemPerPage);
	$end = ceil($page / $btnPerPage) * $btnPerPage;
	$start = $end + 1 - $btnPerPage;
	$btns = [];

	if ($end > $btnPerPage) {
		$btns[$start-1] = 'Prev';
	}

	for ($i = $start; $i <= $end; $i++) {
		$btns[$i] = $i;

		if ($i * 10 > $itemCount) {
			break;
		}
	}

	if ($end * $itemPerPage < $itemCount) {
		$btns[$end+1] = 'Next';
	}

	return $btns;
}


/**
 * Moves the uploaded file to upload directory
 */

function moveUploadedFile(string $directory, \Slim\Http\UploadedFile $uploadedFile)
{
    $extension = pathinfo($uploadedFile->getClientFilename(), PATHINFO_EXTENSION);
    $basename = bin2hex(random_bytes(8));
    $filename = sprintf('%s.%0.8s', $basename, $extension);
    $directory = "../app/storage/$directory";

    if (!file_exists($directory)) {
		mkdir($directory, 0777, true);
	}

    $uploadedFile->moveTo($directory . DIRECTORY_SEPARATOR . $filename);
    return $filename;
}
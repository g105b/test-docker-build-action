<?php
$name = file_get_contents(__DIR__ . "/name.txt");
$name = trim($name);
echo "Hello, $name!", PHP_EOL;
<?php
session_start();
//Cabeçalhos do JSON
header("Content-Type: application/json");
header('Content-Type: text/html; charset=utf-8');

//echo $_SESSION["login"];
//var_dump($_SESSION["senha"]);

//Variáveis para conexão com o banco de dados gabriela (Que roda na Cloud do Google)
$servername = "35.199.122.71";
$username = "bistro";
$password = "1532#&$ajdc";
$dbname = "bistro";

// Cria a conexão com o banco de dados utilizando MYSQLI
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica se a conexão aconteceu com sucesso
if ($conn->connect_error) 
{
   die("Connection failed: " . $conn->connect_error);
} 
echo 'aqui'; exit;
// Define que os caracteres do banco de dados estão codificados em UNICODE UTF-8
mysqli_set_charset($conn,"utf8");

/*

Header of PHP script that select/update gabriela database (to QUIZ GAME)
Author: Raffael Bottoli Schemmer
Date: 04/09/2018

*/

// Catch the area code (informed by login script)
$nmusuario = $_GET['nmusuario'];
$nmsenha = $_GET['nmsenha'];
$tipousuario = $_GET['tipousuario'];

// Search in game database Cod_P of all Cod_D questions with SouN flaged in 0
$query = "SELECT nmusuario FROM login WHERE nmusuario = '$nmusuario' AND nmsenha = '$nmsenha' AND tipousuario = '$tipousuario' AND fgativo = '1'";
$result = $conn->query($query);
if ($result->num_rows > 0){
$_SESSION["login"] = $nmusuario;
$_SESSION["senha"] = $nmsenha;
echo '1';
}
else{
echo '0';
}
?>


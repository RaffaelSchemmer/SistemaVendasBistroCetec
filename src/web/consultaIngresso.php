<?php

//Cabeçalhos do JSON
header("Content-Type: application/json");
header('Content-Type: text/html; charset=utf-8');

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

$query = "SELECT nmusuario FROM login WHERE nmusuario = '$nmusuario' AND nmsenha = '$nmsenha' AND tipousuario = 2 AND fgativo = 1";
$result = $conn->query($query);
if ($result->num_rows > 0)
{
$nmsha = $_GET['nmsha'];
$query = "SELECT nmcliente , nmsha FROM ingresso WHERE nmsha = '$nmsha' AND fgativo = 1";
$result = $conn->query($query);
$row = mysqli_fetch_assoc($result);
if ($result->num_rows > 0)
{
echo '1:';
echo $row["nmcliente"];
$query = "UPDATE ingresso SET fgativo = 0 WHERE nmsha = '$nmsha'";
$result = $conn->query($query);
}
else
{
echo '0:';
}
}
else{
echo '-1:';
}
?>


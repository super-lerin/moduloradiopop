<?php
header('Content-Type: application/json; charset=utf-8');

// Configuração da transmissão ao vivo da Rádio Pop Goiaba UFF
$response = [
    "type" => "live",
    "stationName" => "Rádio Pop Goiaba UFF",
    "description" => "Webrádio alternativa da UFF com programação voltada à cultura, MPB, Rock e vanguarda.",
    "streamUrl" => "https://s37.maxcast.com.br:8450/live"
];

echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
?>
<?php
header('Content-Type: application/json; charset=utf-8');

$baseDir = 'playlists/';
$playlistData = [];

if (is_dir($baseDir)) {
    $subdirs = scandir($baseDir);
    
    foreach ($subdirs as $subdir) {
        if ($subdir === '.' || $subdir === '..') continue;
        
        $subPath = $baseDir . $subdir;
        if (is_dir($subPath)) {
            $files = scandir($subPath);
            $tracks = [];
            
            foreach ($files as $file) {
                $ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));
                if ($ext === 'mp3') {
                    // Nome amigável formatado (substitui hífens/underscores por espaços)
                    $cleanName = ucwords(str_replace(['-', '_'], ' ', pathinfo($file, PATHINFO_FILENAME)));
                    
                    $tracks[] = [
                        'name' => $cleanName,
                        'url' => $subPath . '/' . $file,
                        'folder' => $subdir
                    ];
                }
            }
            
            if (!empty($tracks)) {
                $playlistData[] = [
                    'category' => $subdir,
                    'tracks' => $tracks
                ];
            }
        }
    }
}

echo json_encode($playlistData, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
?>
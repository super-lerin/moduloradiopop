#!/bin/bash

# Cores para saída no terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verifica se o yt-dlp está instalado
if ! command -v yt-dlp &> /dev/null; then
    echo -e "${RED}Erro: yt-dlp não está instalado.${NC}"
    echo "Instale com: sudo apt install yt-dlp (ou atualize via pip)"
    exit 1
fi

# Verifica se o ffmpeg está instalado (necessário para conversão MP3)
if ! command -v ffmpeg &> /dev/null; then
    echo -e "${RED}Erro: ffmpeg não está instalado.${NC}"
    echo "Instale com: sudo apt install ffmpeg"
    exit 1
fi

# Verifica se o link foi passado como argumento
if [ -z "$1" ]; then
    echo -e "${RED}Uso correto:${NC}"
    echo "./baixar_playlist.sh \"URL_DA_PLAYLIST\" [NOME_DA_PASTA_CATEGORIA]"
    exit 1
fi

URL="$1"
CATEGORY="${2:-YouTube_Downloads}" # Se não passar o 2º argumento, usa esta pasta padrão

# Diretório de destino alinhado com o seu projeto web
TARGET_DIR="playlists/$CATEGORY"

echo -e "${GREEN}Iniciando download para a categoria: $CATEGORY${NC}"
mkdir -p "$TARGET_DIR"

# Executa o yt-dlp para extrair apenas áudio em MP3 com alta qualidade
yt-dlp -x --audio-format mp3 --audio-quality 0 \
    --output "$TARGET_DIR/%(title)s.%(ext)s" \
    --restrict-filenames \
    --ignore-errors \
    "$URL"

echo -e "${GREEN}Download finalizado! Os arquivos estão salvos em: $TARGET_DIR${NC}"
echo "Atualize a página do seu player web para que o PHP reconheça os novos arquivos."
# ... (código anterior do yt-dlp)

# Executa o yt-dlp
yt-dlp -x --audio-format mp3 --audio-quality 0 \
    --output "$TARGET_DIR/%(title)s.%(ext)s" \
    --restrict-filenames \
    --ignore-errors \
    "$URL"

# GARANTE QUE O APACHE/PHP CONSEGUIRÃO LER OS ARQUIVOS NOVOS
chmod -R 755 "$TARGET_DIR"

echo -e "${GREEN}Download finalizado! Os arquivos estão salvos em: $TARGET_DIR${NC}"
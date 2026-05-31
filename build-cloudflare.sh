#!/usr/bin/env bash
# ==============================================================================
# Cloudflare Pages 專門詩集專欄建置腳本
# ==============================================================================
# 本腳本旨在實現「雙平台詩集專欄完美分流」：
# 1. 保持根目錄的 index.html 完全不變（繼續指向原本正常的 Netlify 格式，供 GitHub/Netlify 使用）。
# 2. 在編譯時，自動建立獨立的 cloudflare-dist 資料夾，並複製所有靜態資源與詩篇 md 檔案。
# 3. 動態將複製後的網頁頁尾中的 Netlify 字樣修改為 Cloudflare Pages 專屬字樣。
# 4. 指引 Cloudflare Pages 發布此資料夾。

set -euo pipefail

# 1. 清理並建立獨立的部署資料夾
rm -rf cloudflare-dist
mkdir -p cloudflare-dist

# 2. 複製所有靜態網頁與詩歌資源至部署資料夾下
cp index.html poems.json 3731304464704253357_n.jpg cloudflare-dist/
cp -f *.md cloudflare-dist/ 2>/dev/null || true
cp -f *.png *.jpg *.JPG cloudflare-dist/ 2>/dev/null || true

# 3. 在複製出來的檔案中，動態替換頁尾宣告文字，不影響原始 index.html
sed -i 's/適合託管於 Netlify 靜態網頁版格式/適合託管於 Cloudflare Pages 靜態網頁版格式/g' cloudflare-dist/index.html

echo "========== [Cloudflare Poem Build] 建置完成！輸出目錄：cloudflare-dist/ =========="

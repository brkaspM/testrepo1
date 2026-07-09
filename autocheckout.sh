#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}📂 Доступные локальные ветки:${NC}"

# Получаем список веток в массив
mapfile -t branches < <(git branch | sed 's/[* ] //')

# Выводим список с номерами
for i in "${!branches[@]}"; do
    # Помечаем текущую ветку звездочкой
    if git branch | grep -q "* ${branches[$i]}"; then
        echo -e "  $((i+1))) ${GREEN}${branches[$i]} (текущая)${NC}"
    else
        echo "  $((i+1))) ${branches[$i]}"
    fi
done

echo -n "🔢 Введите номер ветки для перехода: "
read -r choice

# Проверяем выбор
if [[ "$choice" -gt 0 && "$choice" -le "${#branches[@]}" ]]; then
    TARGET_BRANCH="${branches[$((choice-1))]}"
    echo -e "${GREEN}🚀 Переключаемся на $TARGET_BRANCH...${NC}"
    git checkout "$TARGET_BRANCH"
else
    echo -e "\033[0;31m❌ Неверный выбор!${NC}"
fi

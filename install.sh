#!/usr/bin/env bash
# Запуск: откройте Терминал в этой папке и выполните
#     bash install.sh

cd "$(dirname "$0")" || exit 1

echo "  Установка всего нужного для мастер-класса по OpenCV"
echo "  Просто подождите. Если попросят пароль - введите пароль"
echo "  от компьютера (буквы при вводе не видны, это нормально)."
echo "============================================================"
echo

apt_install() {
    if command -v apt-get >/dev/null 2>&1 && command -v sudo >/dev/null 2>&1; then
        echo "[..] Устанавливаю системные пакеты: $*"
        sudo apt-get update -qq && sudo apt-get install -y -qq "$@"
    else
        return 1
    fi
}


if ! "$PY" -m pip --version >/dev/null 2>&1; then
    echo "[..] pip не найден, пробую установить..."
    "$PY" -m ensurepip --user >/dev/null 2>&1 || apt_install python3-pip
    if ! "$PY" -m pip --version >/dev/null 2>&1; then
        echo "[ОШИБКА] Не удалось установить pip."
        echo "  Выполните:  sudo apt install python3-pip"
        echo "  и запустите этот скрипт ещё раз."
        exit 1
    fi
fi
echo "[OK] pip на месте"
echo

echo "[..] Устанавливаю библиотеки OpenCV и numpy (может занять пару минут)..."
PIP_ARGS="--disable-pip-version-check -r requirements.txt"

if "$PY" -c 'import sys; sys.exit(sys.prefix == sys.base_prefix)'; then
    USER_FLAG=""
else
    USER_FLAG="--user"
fi


if [ -n "$USER_FLAG" ] && "$PY" -c 'import os, sys, sysconfig; sys.exit(not os.path.exists(os.path.join(sysconfig.get_path("stdlib"), "EXTERNALLY-MANAGED")))'; then
    BREAK_FLAG="--break-system-packages"
else
    BREAK_FLAG=""
fi

if "$PY" -m pip install $USER_FLAG $BREAK_FLAG $PIP_ARGS; then
    echo "[OK] Библиотеки установлены."
else
    echo
    echo "[ОШИБКА] Не удалось установить библиотеки."
    echo "  Проверьте, что есть интернет, и запустите скрипт ещё раз."
    echo "  Если не помогло - позовите преподавателя и покажите это окно."
    exit 1
fi

# ---------- 5. Проверяем, что всё работает ----------
"$PY" check_setup.py

#!/bin/bash

# گرفتن ورودی‌ها از کاربر
read -p "Enter Database Name: " db_name
read -p "Enter Database Username: " db_user
read -sp "Enter Database Password: " db_pass
echo

# بررسی نصب بودن phpMyAdmin
if ! dpkg -l | grep -q phpmyadmin; then
    echo "phpMyAdmin not found. Installing phpMyAdmin..."
    sudo apt update
    sudo apt install -y phpmyadmin
else
    echo "phpMyAdmin is already installed."
fi

# ایجاد دیتابیس
echo "Creating database $db_name..."
mysql -u root -p -e "CREATE DATABASE $db_name;"

# ایجاد کاربر و اختصاص دسترسی‌ها
echo "Creating user $db_user with password and granting privileges..."
mysql -u root -p -e "CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_pass';"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';"
mysql -u root -p -e "FLUSH PRIVILEGES;"

echo "Database and user created successfully!"

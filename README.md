# blog

Исходники сайта лежат в `jl4ctukblog/`.

Первичная настройка после клона:

```bash
git submodule update --init --recursive
```

Локальный предпросмотр:

```bash
./scripts/hugo.sh server -D --source jl4ctukblog
```

Публикация в `jl4ctuk.github.io`:

```bash
./scripts/publish.sh
```

Скрипт сам:

- инициализирует submodule,
- использует системный `hugo`, если он `>= 0.128.0`,
- иначе скачивает совместимый `hugo extended` в `.tools/`.

После сборки остаётся закоммитить изменения в обоих репозиториях:

```bash
git add .gitmodules README.md scripts .gitignore jl4ctukblog/content
git commit -m "..."
git push

git -C jl4ctukblog/public add -A
git -C jl4ctukblog/public commit -m "..."
git -C jl4ctukblog/public push origin main
```

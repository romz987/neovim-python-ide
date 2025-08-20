# Pyright

## Abstracts

Частичное и краткое описание LSP-сервера Pyright от Microsoft

## Table of Contents

- [About](#About)
- [Special comments](#Special-comments)
- [Pyright-vs-Jedi](#Pyright-vs-Jedi)
- [Bibliography](#bibliography)
- [TODO](#TODO)

## About

> [!NOTE]
>
> Коротко о Pyright

## Special comments

**#type: ignore**

- Используется для игнорирования ошибок типизации на конкретной строке.

```python
x = "string"  # type: ignore
```

**#pyright: reportMissingImports=false**

- Отключает предупреждения о недостающих импортируемых модулях для всего файла.

```python
# pyright: reportMissingImports=false
```

**#pyright: reportUnusedImport=false**

- Отключает предупреждения о неиспользуемых импортируемых модулях.

```python
# pyright: reportUnusedImport=false
```

**#pyright: reportGeneralTypeIssues=false**

- Отключает общие предупреждения о проблемах с типами.

```python
# pyright: reportGeneralTypeIssues=false
```

**#pyright: strict=false**

- Отключает строгую проверку типов для всего файла.

```python
# pyright: strict=false
```

## Pyright vs Jedi

Сравнение pyright и jedi-language-server

## Bibliography

[Pyright GitHub](https://github.com/microsoft/pyright)  
[Pyright Web](https://microsoft.github.io/pyright/#/)

## TODO

Сгруппировать параметры конфигурации с сайта и сделать для них короткое описание

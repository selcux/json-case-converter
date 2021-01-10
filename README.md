# json-case-converter

Converts JSON keys to different case type such as snake case, camel case, pascal case etc.

## Usage

```sh
racket json-case-converter.rkt [-f snake | pascal | camel | kebab] /path/to/file.json
```

or

```sh
chmod +x json-case-converter.rkt
./json-case-converter.rkt [-f snake | pascal | camel | kebab] /path/to/file.json
```

Supported types:

- snake case
- pascal case
- camel case
- kebab case

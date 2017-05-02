# elm-jsonresume
**Opinionated`*` Elm Decoders for jsonresume.org**

`*`*All fields in jsonresume are optional. This package assumes some sane defaults, like every work experience must have the companys name and your position*

## Representation of empty / null
All fields in jsonresume are optional.
At first I represented all strings as `Maybe String`, only to realise that I would later use `text (Maybe.withDefault "" value)` in my views, so the result is `<div><div>`, which is not rendered.
If you want to check if the value is present, use `String.isEmpty`.

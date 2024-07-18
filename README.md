# Discourse CJK Formatter Plugin

A Discourse plugin that can reformat topic titles and post texts with mixed CJK and Latin characters and support auto space padding and punctuations correction.

### Features

Writing mixed CJK(Chinese, Japanese, Korean) characters and Latin characters can be a pain because of the special effort to take on the format. This plugin comes in to automatically reformat topic titles and post contents for you, utilizing [autocorrect-rb](https://github.com/huacnlee/autocorrect/tree/main/autocorrect-rb).

Every time a topic/post is created or updated, its content (and title) will get:
* added space between CJK (full width) and Latin (half-width) character
* corrected punctuation adjacent to CJK character into full-width
* corrected punctuation adjacent to Latin character into half-width

### Configuration

After installation, it will work for new posts.

To reformat all historic posts, use `rake`:
```sh
rake cjk:reformat
rake posts:rebake
```

## Disclaimer
Before use, be sure to learn about how the [`autocorrect`](https://github.com/huacnlee/autocorrect) tool will modify your content and backup your data before continue!

## Acknowledgement
* https://github.com/huacnlee/autocorrect
* https://github.com/openSUSE-zh/discourse-cjk-text-spacing

For more information, please see: https://meta.discourse.org/t/cjk-formatter-plugin/316533

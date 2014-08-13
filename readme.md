# Introduction
Experiment that produces algorithmic drawings.

## Setup

This will work for the most part.  The catch being that the `run` script assumes
`open` will launch a preview of the image generated.  On Mac this works fine, but
untested on other OSes.

```
%> git clone [this-repo]
%> npm install
%> ./run [graphing, sandgrains, soft-red, soft-yellow, vlade]

```

## Examples

See the images in the `exhibit` directory.  By default `index.js` will place generated
images in the `images/` dir, but `all.js` will put them in `exhibit/`.


## License

See license file.

The use and distribution terms for this software are covered by the
[Eclipse Public License 1.0][EPL-1], which can be found in the file 'license' at the
root of this distribution. By using this software in any fashion, you are
agreeing to be bound by the terms of this license. You must not remove this
notice, or any other, from this software.


[EPL-1]: http://opensource.org/licenses/eclipse-1.0.txt
[checkArgs]: http://docs.guava-libraries.googlecode.com/git/javadoc/com/google/common/base/Preconditions.html

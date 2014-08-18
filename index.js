#!/usr/bin/env node

require('coffee-script/register');

var path        = require('path');
var fs          = require('fs');
var drawings    = require('./src/');

var savesDir    = 'saves/';

function copySource(name, stamp) {
    var filename = name + ".coffee";
    var src = path.resolve(__dirname, "./src/", filename);
    var target = path.resolve(__dirname, savesDir, ""+stamp+"-"+filename);
    copyFile(src, target)
}

function copyFile(src, target) {
    console.log('copying src', src);
    console.log('copying target', target);
    ins = fs.readFileSync(src);
    fs.writeFileSync(target, ins)
}


var argv = process.argv;

if (argv.length < 3) {
    console.log("Please provide image name")
}
else {
    var name = argv[2];
    var isSaving = argv.length >= 4 && argv[3] == '--save';
    var baseDir = isSaving ? "saves/" : "images/";
    var dir = path.resolve(__dirname, baseDir);

    a = JSON.stringify({
        argv        : argv,
        name        : name,
        isSaving    : isSaving,
        baseDir     : baseDir,
        dir         : dir
    }, null, '  ');

    if (isSaving) {
        var stamp = isSaving ? "" + Date.now() : undefined;
        copySource(name, stamp)
    }
    drawings(dir, stamp)[name]()
}


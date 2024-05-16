const fs = require('fs');
const path = require('path');

function rewriteImports(directory) {
    const files = fs.readdirSync(directory);

    for (let file of files) {
        const filePath = path.join(directory, file);
        if (fs.statSync(filePath).isDirectory()) {
            rewriteImports(filePath);
        } else if (filePath.endsWith('.js')) {
            let content = fs.readFileSync(filePath, 'utf8');
            content = content.replace(/from '(.*)\.ts'/g, "from '$1.js'");
            fs.writeFileSync(filePath, content, 'utf8');
        }
    }
}

rewriteImports('./dist');
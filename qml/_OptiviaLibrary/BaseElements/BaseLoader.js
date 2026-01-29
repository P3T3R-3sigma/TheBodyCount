function shadowExtractNames(qrcFile, filter) {
    let names = []
    let split0 = qrcFile.split("<file>")
    let split1 = []
    let split2 = []
    for (let i in split0) {
        split1.push(...split0[i].split("</file>"))
    }
    for (let j in split1) {
        if (split1[j].includes(filter)) {
            names.push(split1[j])
        }
    }
    return names
}

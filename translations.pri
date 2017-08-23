# Supported languages
LANGUAGES = af ar be bg cs da de el en es et fi fil fr hi id it ja ko lt ms nl no pl pt_BR pt_PT ru sk sl sq sr sv th tr uk vi zh

# Make the ts files show up in the Qt Creator file browser
OTHER_FILES += $$files($${PWD}/*.ts, true)

# Set the ts file paths based on the specified supported languages
defineReplace(prependAll) {
    for(a,$$1):result '' += $$2$${a}$$3
    return($$result)
}

EN = en
ENGLISH_TRANSLATION = $$prependAll(EN, $${PWD}/app/geometrize_, .ts)
TRANSLATIONS = $$prependAll(LANGUAGES, $${PWD}/app/geometrize_, .ts)

# Automatically update the ts files for the given languages
# Note that all the ts files other than the "master" en.ts are managed by Transifex
# So, we only update the English .ts file here
qtPrepareTool(LUPDATE, lupdate)
LUPDATE += -locations relative -no-ui-lines

#TSFILES = $$TRANSLATIONS
#for(file, TSFILES) {
#    command = cd $$shell_quote($$_PRO_FILE_PWD_) && $$LUPDATE -silent $$shell_quote($$_PRO_FILE_) -ts $$shell_quote($${file})
#    system($$command)|error("Failed to update ts file")
#}

#command = cd $$shell_quote($$_PRO_FILE_PWD_) && $$LUPDATE -silent $$shell_quote($$_PRO_FILE_) -ts $$shell_quote($${ENGLISH_TRANSLATION})
#system($$command)|error("Failed to update ts file")

# Generate qm files from the ts files for the supported languages and place them in the resources folder, ready to be bundled as resources
qtPrepareTool(LRELEASE, lrelease)
for(language, LANGUAGES) {
    tsfile = $$shell_path($$shell_quote($${PWD}/app/geometrize_$${language}.ts))
    qmfile = $$shell_path($$shell_quote($${PWD}/../resources/translations/app/geometrize_$${language}.qm))
    command = $$shell_path($$shell_quote($${LRELEASE})) -removeidentical $${tsfile} -qm $${qmfile}
    system($${command})|error("Failed to generate qm file")
}

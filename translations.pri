# Supported languages
LANGUAGES = ar bg cs da de el en es fi fr id it ja ko ms nl no pl pt pt_BR ru sk sr sv th tr uk vi zh

# Make the ts files show up in the Qt Creator file browser
OTHER_FILES += $$files($${PWD}/*.ts, true)

# Set the ts file paths based on the specified supported languages
defineReplace(prependAll) {
    for(a,$$1):result '' += $$2$${a}$$3
    return($$result)
}

# Automatically update the ts files for the given languages
# Note that all the ts files other than the "master" en.ts are managed by Transifex
# So, we only update the English .ts file here

# Disabled for now since we don't need to constantly update the English ts
# EN = en
# ENGLISH_TRANSLATION = $$prependAll(EN, $${PWD}/app/geometrize_, .ts)
#qtPrepareTool(LUPDATE, lupdate)
#LUPDATE += -locations relative -no-ui-line
#command = cd $$shell_quote($$_PRO_FILE_PWD_) && $$LUPDATE -silent $$shell_quote($$_PRO_FILE_) -ts $$shell_quote($${ENGLISH_TRANSLATION})
#system($$command)|error("Failed to update English ts file")

# Generate qm files from the ts files for the supported languages and place them in the resources folder, ready to be bundled as resources
qtPrepareTool(LRELEASE, lrelease)
for(language, LANGUAGES) {
    tsfile = $$system_path($${PWD}/app/geometrize_$${language}.ts)
    qmfile = $$system_path($${PWD}/../resources/translations/app/geometrize_$${language}.qm)

    # For some reason AppVeyor mingw builds put single quotes around the lrelease path, this removes them
    lrelease_path = $$replace(LRELEASE, \',)

    command = "\"$${lrelease_path}\"" -removeidentical "\"$${tsfile}\"" -qm "\"$${qmfile}\""
    message("Will run lrelease:")
    message($${command})
    system($${command})|error("Failed to generate qm file")
}

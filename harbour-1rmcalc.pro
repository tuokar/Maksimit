# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-1rmcalc

CONFIG += sailfishapp

SOURCES += src/harbour-1rmcalc.cpp

OTHER_FILES += qml/harbour-1rmcalc.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-1rmcalc.spec \
    rpm/harbour-1rmcalc.yaml \
    translations/*.ts \
    harbour-1rmcalc.desktop \
    qml/pages/Main.qml \
    qml/pages/Info.qml \
    qml/pages/Help.qml \
    qml/pages/About.qml \
    rpm/harbour-1rmcalc.changes

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-1rmcalc-de.ts


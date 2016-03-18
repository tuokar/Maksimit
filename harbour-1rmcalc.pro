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
TARGET = harbour-maksimit

CONFIG += sailfishapp

SOURCES += \
    src/harbour-maksimit.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    translations/*.ts \
    qml/pages/AboutPage.qml \
    qml/pages/HelpPage.qml \
    qml/pages/MainPage.qml \
    qml/Preferences.js \
    qml/js/Preferences.js \
    qml/harbour-maksimit.qml \
    harbour-maksimit.desktop \
    rpm/harbour-maksimit.yaml \
    rpm/harbour-maksimit.spec \
    rpm/harbour-maksimit.changes \
    qml/pages/SettingsPage.qml \
    qml/pages/Percentages1RM.qml \
    qml/pages/PercentagesRepMax.qml \
    qml/pages/CalcPage1RM.qml \
    qml/pages/CalcPageRepMax.qml


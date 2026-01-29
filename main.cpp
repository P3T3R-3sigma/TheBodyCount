#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
#include <QResource>
#include <QDebug>

// Uncomment this line to add Felgo Hot Reload and use hot reloading with your custom C++ code
//#include <FelgoHotReload>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    FelgoApplication felgo;

    // Use Felgo's default font instead of platform-specific fonts
    felgo.setPreservePlatformFonts(false);

    const char* resourceList[] = {
        "image_assets.rcc",
        "audio_assets.rcc",
        "BC_comedy_assets.rcc",
        "BC_Sex_Amber.rcc",
        "BC_Sex_Milena_Lollypop.rcc",
        "BC_Sex_Milena_Lollypop.rcc",
    };

    for (const char* file : resourceList) {
        if (QResource::registerResource(QString(file))) {
            qDebug() << "Succeded to register " + QString(file);
        } else {
            qDebug() << "Failed to register " + QString(file);
        }
    }

    qputenv("QML_XHR_ALLOW_FILE_READ", QString("1").toUtf8());
    QQmlApplicationEngine engine;
    felgo.initialize(&engine);

    // Set an optional license key from project file
    // This does not work if using Felgo Developer App, only for Felgo Cloud Builds and local builds
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

    // use this during development
    // for PUBLISHING, use the entry point below
    // felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
    // this is the preferred deployment option for publishing apps to the app stores, because then your qml files and js files are protected
    // to avoid deployment of your qml files and images, also comment the deploy_resources command in the CMakeLists file
    // also see the CMakeLists.txt file for more details
    felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

    engine.load(QUrl(felgo.mainQmlFileName()));

    // to start your project with Felgo Hot Reload, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
    // and uncomment the line below
    //FelgoHotReload felgoHotReload(&engine);

    return app.exec();
}

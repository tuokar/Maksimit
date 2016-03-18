.pragma library
.import QtQuick.LocalStorage 2.0 as LS

function getDatabase() {
    return LS.LocalStorage.openDatabaseSync("Maksimit", "", "Maksimit database", 10000);
}

function initializeDatabase() {
    try {
        var db = getDatabase();

        if(db.version == "") {
            db.changeVersion("", "1",
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS preferences(key TEXT UNIQUE, value TEXT)');
                    tx.executeSql('INSERT INTO preferences(key, value) VALUES ("kgValue", "20")');
                    tx.executeSql('INSERT INTO preferences(key, value) VALUES ("lbValue", "45")');
                    tx.executeSql('INSERT INTO preferences(key, value) VALUES ("repsValue", "2")');
                    tx.executeSql('INSERT INTO preferences(key, value) VALUES ("kgUnit", "1")');
                    tx.executeSql('INSERT INTO preferences(key, value) VALUES ("lbUnit", "0")');
                    tx.executeSql('INSERT INTO preferences(key, value) VALUES ("kgIncrement", "2.5")');
                    tx.executeSql('INSERT INTO preferences(key, value) VALUES ("lbIncrement", "5.0")');
                    console.debug("Tables created!")
                }
            );
        }
    }

    catch (e) {
        console.log("Could not open DB: " + e);
    }

    return db;
}

function set(key, value) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {

        var rs = tx.executeSql('INSERT OR REPLACE INTO preferences VALUES(?, ?);', [key, value]);

        if (rs.rowsAffected > 0) {
            res = "OK";
            //console.debug("Write value: " + key + ", " + value)
        }

        else {
            res = "Error";
            console.log("Error while setting value")
        }
    });

    return res;
}

function get(key, defaultValue) {
    var db = getDatabase();
    var res = "";

    try {
        db.transaction(function(tx) {

            var rs = tx.executeSql('SELECT value FROM preferences WHERE key=?;', [key]);

            for(var i = 0; i < rs.rows.length; i++) {
                var r = rs.rows.item(i);
                    res = r.value;
                    //console.debug("Setting fetched: " + key + ", " + r.value)
            }
        })
    }

    catch (e) {
        console.log("Could not get setting " + e);
        res = defaultValue;
    };

    return res
}

function resetDatabase() {
    var db = getDatabase();
    var respath = "";

    db.transaction(function(tx) {
        tx.executeSql('DROP TABLE IF EXISTS preferences;');
        db.changeVersion("1", "");
        //console.debug("Database reset!")
    });

    initializeDatabase();
}

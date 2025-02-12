# Experimental!
Uiqlite ~ "../uiqlite/lib" ~ Tables!

Tables!"chinook.db"

# executes a uiua style query directly on chinook.db
Execute! ←^ $"Uiqlite~Execute!(_) \"chinook.db\"" /◇$"_|_"

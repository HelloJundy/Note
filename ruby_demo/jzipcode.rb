require 'sqlite3'

class JZipCode
  def initialize(dbfile)
    @dbfile = dbfile
  end

  def make_db(zipfile)
    p zipfile
    # return if File.exists?(@dbfile)
    p zipfile
    SQLite3::Database.open(@dbfile) do |db|
      db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS zips
        (code TEXT, pref TEXT, city TEXT, addr TEXT, alladdr TEXT)
      SQL
      File.open(zipfile, 'r:shift_jis') do |zip|
        db.execute "BEGIN TRANSACTION"
        zip.each_line do |line|
          columns = line.split(",").map{|col| col.delete('"')}
          code = columns[2]
          pref = columns[6]
          city = columns[7]
          addr = columns[8]
          all_addr = pref + city + addr
          db.execute "INSERT INTO zips VALUES (?,?,?,?,?)",[code, pref, city, addr, all_addr]
          p line
      end
      db.execute "COMMIT TRANSACTION"
      end  
    end
  end

  def find_by_code(code)
    sql = "SELECT * FROM zips WHERE code = ?"
    str = ""
    SQLite3::Database.open(@dbfile) do |db|
      db.execute(sql,code) do |row|
        str << sprintf("%s %s", row[0], row[4]) << "\n"
      end
    end
    str
  end
end


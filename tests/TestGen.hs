module TestGen(tests) where
import TestUtil
import qualified System.FilePath.Windows as W
import qualified System.FilePath.Posix as P
tests :: [(String, Test)]
tests =
    [("W.pathSeparator == '\\\\'", test $ W.pathSeparator == '\\')
    ,("P.pathSeparator == '/'", test $ P.pathSeparator == '/')
    ,("P.isPathSeparator P.pathSeparator", test $ P.isPathSeparator P.pathSeparator)
    ,("W.isPathSeparator W.pathSeparator", test $ W.isPathSeparator W.pathSeparator)
    ,("W.pathSeparators == ['\\\\', '/']", test $ W.pathSeparators == ['\\', '/'])
    ,("P.pathSeparators == ['/']", test $ P.pathSeparators == ['/'])
    ,("P.pathSeparator `elem` P.pathSeparators", test $ P.pathSeparator `elem` P.pathSeparators)
    ,("W.pathSeparator `elem` W.pathSeparators", test $ W.pathSeparator `elem` W.pathSeparators)
    ,("P.isPathSeparator a == (a `elem` P.pathSeparators)", test $ \a -> P.isPathSeparator a == (a `elem` P.pathSeparators))
    ,("W.isPathSeparator a == (a `elem` W.pathSeparators)", test $ \a -> W.isPathSeparator a == (a `elem` W.pathSeparators))
    ,("W.searchPathSeparator == ';'", test $ W.searchPathSeparator == ';')
    ,("P.searchPathSeparator == ':'", test $ P.searchPathSeparator == ':')
    ,("P.isSearchPathSeparator a == (a == P.searchPathSeparator)", test $ \a -> P.isSearchPathSeparator a == (a == P.searchPathSeparator))
    ,("W.isSearchPathSeparator a == (a == W.searchPathSeparator)", test $ \a -> W.isSearchPathSeparator a == (a == W.searchPathSeparator))
    ,("P.extSeparator == '.'", test $ P.extSeparator == '.')
    ,("W.extSeparator == '.'", test $ W.extSeparator == '.')
    ,("P.isExtSeparator a == (a == P.extSeparator)", test $ \a -> P.isExtSeparator a == (a == P.extSeparator))
    ,("W.isExtSeparator a == (a == W.extSeparator)", test $ \a -> W.isExtSeparator a == (a == W.extSeparator))
    ,("P.splitSearchPath \"File1:File2:File3\" == [\"File1\", \"File2\", \"File3\"]", test $ P.splitSearchPath "File1:File2:File3" == ["File1", "File2", "File3"])
    ,("P.splitSearchPath \"File1::File2:File3\" == [\"File1\", \".\", \"File2\", \"File3\"]", test $ P.splitSearchPath "File1::File2:File3" == ["File1", ".", "File2", "File3"])
    ,("W.splitSearchPath \"File1;File2;File3\" == [\"File1\", \"File2\", \"File3\"]", test $ W.splitSearchPath "File1;File2;File3" == ["File1", "File2", "File3"])
    ,("W.splitSearchPath \"File1;;File2;File3\" == [\"File1\", \"File2\", \"File3\"]", test $ W.splitSearchPath "File1;;File2;File3" == ["File1", "File2", "File3"])
    ,("W.splitSearchPath \"File1;\\\"File2\\\";File3\" == [\"File1\", \"File2\", \"File3\"]", test $ W.splitSearchPath "File1;\"File2\";File3" == ["File1", "File2", "File3"])
    ,("uncurry (++) (P.splitExtension x) == x", test $ \(QFilePath x) -> uncurry (++) (P.splitExtension x) == x)
    ,("uncurry (++) (W.splitExtension x) == x", test $ \(QFilePath x) -> uncurry (++) (W.splitExtension x) == x)
    ,("uncurry P.addExtension (P.splitExtension x) == x", test $ \(QFilePathValidP x) -> uncurry P.addExtension (P.splitExtension x) == x)
    ,("uncurry W.addExtension (W.splitExtension x) == x", test $ \(QFilePathValidW x) -> uncurry W.addExtension (W.splitExtension x) == x)
    ,("P.splitExtension \"file.txt\" == (\"file\", \".txt\")", test $ P.splitExtension "file.txt" == ("file", ".txt"))
    ,("W.splitExtension \"file.txt\" == (\"file\", \".txt\")", test $ W.splitExtension "file.txt" == ("file", ".txt"))
    ,("P.splitExtension \"file\" == (\"file\", \"\")", test $ P.splitExtension "file" == ("file", ""))
    ,("W.splitExtension \"file\" == (\"file\", \"\")", test $ W.splitExtension "file" == ("file", ""))
    ,("P.splitExtension \"file/file.txt\" == (\"file/file\", \".txt\")", test $ P.splitExtension "file/file.txt" == ("file/file", ".txt"))
    ,("W.splitExtension \"file/file.txt\" == (\"file/file\", \".txt\")", test $ W.splitExtension "file/file.txt" == ("file/file", ".txt"))
    ,("P.splitExtension \"file.txt/boris\" == (\"file.txt/boris\", \"\")", test $ P.splitExtension "file.txt/boris" == ("file.txt/boris", ""))
    ,("W.splitExtension \"file.txt/boris\" == (\"file.txt/boris\", \"\")", test $ W.splitExtension "file.txt/boris" == ("file.txt/boris", ""))
    ,("P.splitExtension \"file.txt/boris.ext\" == (\"file.txt/boris\", \".ext\")", test $ P.splitExtension "file.txt/boris.ext" == ("file.txt/boris", ".ext"))
    ,("W.splitExtension \"file.txt/boris.ext\" == (\"file.txt/boris\", \".ext\")", test $ W.splitExtension "file.txt/boris.ext" == ("file.txt/boris", ".ext"))
    ,("P.splitExtension \"file/path.txt.bob.fred\" == (\"file/path.txt.bob\", \".fred\")", test $ P.splitExtension "file/path.txt.bob.fred" == ("file/path.txt.bob", ".fred"))
    ,("W.splitExtension \"file/path.txt.bob.fred\" == (\"file/path.txt.bob\", \".fred\")", test $ W.splitExtension "file/path.txt.bob.fred" == ("file/path.txt.bob", ".fred"))
    ,("P.splitExtension \"file/path.txt/\" == (\"file/path.txt/\", \"\")", test $ P.splitExtension "file/path.txt/" == ("file/path.txt/", ""))
    ,("W.splitExtension \"file/path.txt/\" == (\"file/path.txt/\", \"\")", test $ W.splitExtension "file/path.txt/" == ("file/path.txt/", ""))
    ,("P.takeExtension x == snd (P.splitExtension x)", test $ \(QFilePath x) -> P.takeExtension x == snd (P.splitExtension x))
    ,("W.takeExtension x == snd (W.splitExtension x)", test $ \(QFilePath x) -> W.takeExtension x == snd (W.splitExtension x))
    ,("P.takeExtension (P.addExtension x \"ext\") == \".ext\"", test $ \(QFilePathValidP x) -> P.takeExtension (P.addExtension x "ext") == ".ext")
    ,("W.takeExtension (W.addExtension x \"ext\") == \".ext\"", test $ \(QFilePathValidW x) -> W.takeExtension (W.addExtension x "ext") == ".ext")
    ,("P.takeExtension (P.replaceExtension x \"ext\") == \".ext\"", test $ \(QFilePathValidP x) -> P.takeExtension (P.replaceExtension x "ext") == ".ext")
    ,("W.takeExtension (W.replaceExtension x \"ext\") == \".ext\"", test $ \(QFilePathValidW x) -> W.takeExtension (W.replaceExtension x "ext") == ".ext")
    ,("P.replaceExtension \"file.txt\" \".bob\" == \"file.bob\"", test $ P.replaceExtension "file.txt" ".bob" == "file.bob")
    ,("W.replaceExtension \"file.txt\" \".bob\" == \"file.bob\"", test $ W.replaceExtension "file.txt" ".bob" == "file.bob")
    ,("P.replaceExtension \"file.txt\" \"bob\" == \"file.bob\"", test $ P.replaceExtension "file.txt" "bob" == "file.bob")
    ,("W.replaceExtension \"file.txt\" \"bob\" == \"file.bob\"", test $ W.replaceExtension "file.txt" "bob" == "file.bob")
    ,("P.replaceExtension \"file\" \".bob\" == \"file.bob\"", test $ P.replaceExtension "file" ".bob" == "file.bob")
    ,("W.replaceExtension \"file\" \".bob\" == \"file.bob\"", test $ W.replaceExtension "file" ".bob" == "file.bob")
    ,("P.replaceExtension \"file.txt\" \"\" == \"file\"", test $ P.replaceExtension "file.txt" "" == "file")
    ,("W.replaceExtension \"file.txt\" \"\" == \"file\"", test $ W.replaceExtension "file.txt" "" == "file")
    ,("P.replaceExtension \"file.fred.bob\" \"txt\" == \"file.fred.txt\"", test $ P.replaceExtension "file.fred.bob" "txt" == "file.fred.txt")
    ,("W.replaceExtension \"file.fred.bob\" \"txt\" == \"file.fred.txt\"", test $ W.replaceExtension "file.fred.bob" "txt" == "file.fred.txt")
    ,("P.dropExtension x == fst (P.splitExtension x)", test $ \(QFilePath x) -> P.dropExtension x == fst (P.splitExtension x))
    ,("W.dropExtension x == fst (W.splitExtension x)", test $ \(QFilePath x) -> W.dropExtension x == fst (W.splitExtension x))
    ,("P.addExtension \"file.txt\" \"bib\" == \"file.txt.bib\"", test $ P.addExtension "file.txt" "bib" == "file.txt.bib")
    ,("W.addExtension \"file.txt\" \"bib\" == \"file.txt.bib\"", test $ W.addExtension "file.txt" "bib" == "file.txt.bib")
    ,("P.addExtension \"file.\" \".bib\" == \"file..bib\"", test $ P.addExtension "file." ".bib" == "file..bib")
    ,("W.addExtension \"file.\" \".bib\" == \"file..bib\"", test $ W.addExtension "file." ".bib" == "file..bib")
    ,("P.addExtension \"file\" \".bib\" == \"file.bib\"", test $ P.addExtension "file" ".bib" == "file.bib")
    ,("W.addExtension \"file\" \".bib\" == \"file.bib\"", test $ W.addExtension "file" ".bib" == "file.bib")
    ,("P.addExtension \"/\" \"x\" == \"/.x\"", test $ P.addExtension "/" "x" == "/.x")
    ,("W.addExtension \"/\" \"x\" == \"/.x\"", test $ W.addExtension "/" "x" == "/.x")
    ,("P.takeFileName (P.addExtension (P.addTrailingPathSeparator x) \"ext\") == \".ext\"", test $ \(QFilePathValidP x) -> P.takeFileName (P.addExtension (P.addTrailingPathSeparator x) "ext") == ".ext")
    ,("W.takeFileName (W.addExtension (W.addTrailingPathSeparator x) \"ext\") == \".ext\"", test $ \(QFilePathValidW x) -> W.takeFileName (W.addExtension (W.addTrailingPathSeparator x) "ext") == ".ext")
    ,("W.addExtension \"\\\\\\\\share\" \".txt\" == \"\\\\\\\\share\\\\.txt\"", test $ W.addExtension "\\\\share" ".txt" == "\\\\share\\.txt")
    ,("null (P.takeExtension x) == not (P.hasExtension x)", test $ \(QFilePath x) -> null (P.takeExtension x) == not (P.hasExtension x))
    ,("null (W.takeExtension x) == not (W.hasExtension x)", test $ \(QFilePath x) -> null (W.takeExtension x) == not (W.hasExtension x))
    ,("uncurry (++) (P.splitExtensions x) == x", test $ \(QFilePath x) -> uncurry (++) (P.splitExtensions x) == x)
    ,("uncurry (++) (W.splitExtensions x) == x", test $ \(QFilePath x) -> uncurry (++) (W.splitExtensions x) == x)
    ,("uncurry P.addExtension (P.splitExtensions x) == x", test $ \(QFilePathValidP x) -> uncurry P.addExtension (P.splitExtensions x) == x)
    ,("uncurry W.addExtension (W.splitExtensions x) == x", test $ \(QFilePathValidW x) -> uncurry W.addExtension (W.splitExtensions x) == x)
    ,("P.splitExtensions \"file.tar.gz\" == (\"file\", \".tar.gz\")", test $ P.splitExtensions "file.tar.gz" == ("file", ".tar.gz"))
    ,("W.splitExtensions \"file.tar.gz\" == (\"file\", \".tar.gz\")", test $ W.splitExtensions "file.tar.gz" == ("file", ".tar.gz"))
    ,("not $ P.hasExtension (P.dropExtensions x)", test $ \(QFilePath x) -> not $ P.hasExtension (P.dropExtensions x))
    ,("not $ W.hasExtension (W.dropExtensions x)", test $ \(QFilePath x) -> not $ W.hasExtension (W.dropExtensions x))
    ,("P.takeExtensions \"file.tar.gz\" == \".tar.gz\"", test $ P.takeExtensions "file.tar.gz" == ".tar.gz")
    ,("W.takeExtensions \"file.tar.gz\" == \".tar.gz\"", test $ W.takeExtensions "file.tar.gz" == ".tar.gz")
    ,("uncurry (++) (P.splitDrive x) == x", test $ \(QFilePath x) -> uncurry (++) (P.splitDrive x) == x)
    ,("uncurry (++) (W.splitDrive x) == x", test $ \(QFilePath x) -> uncurry (++) (W.splitDrive x) == x)
    ,("W.splitDrive \"file\" == (\"\", \"file\")", test $ W.splitDrive "file" == ("", "file"))
    ,("W.splitDrive \"c:/file\" == (\"c:/\", \"file\")", test $ W.splitDrive "c:/file" == ("c:/", "file"))
    ,("W.splitDrive \"c:\\\\file\" == (\"c:\\\\\", \"file\")", test $ W.splitDrive "c:\\file" == ("c:\\", "file"))
    ,("W.splitDrive \"\\\\\\\\shared\\\\test\" == (\"\\\\\\\\shared\\\\\", \"test\")", test $ W.splitDrive "\\\\shared\\test" == ("\\\\shared\\", "test"))
    ,("W.splitDrive \"\\\\\\\\shared\" == (\"\\\\\\\\shared\", \"\")", test $ W.splitDrive "\\\\shared" == ("\\\\shared", ""))
    ,("W.splitDrive \"\\\\\\\\?\\\\UNC\\\\shared\\\\file\" == (\"\\\\\\\\?\\\\UNC\\\\shared\\\\\", \"file\")", test $ W.splitDrive "\\\\?\\UNC\\shared\\file" == ("\\\\?\\UNC\\shared\\", "file"))
    ,("W.splitDrive \"\\\\\\\\?\\\\UNCshared\\\\file\" == (\"\\\\\\\\?\\\\\", \"UNCshared\\\\file\")", test $ W.splitDrive "\\\\?\\UNCshared\\file" == ("\\\\?\\", "UNCshared\\file"))
    ,("W.splitDrive \"\\\\\\\\?\\\\d:\\\\file\" == (\"\\\\\\\\?\\\\d:\\\\\", \"file\")", test $ W.splitDrive "\\\\?\\d:\\file" == ("\\\\?\\d:\\", "file"))
    ,("W.splitDrive \"/d\" == (\"\", \"/d\")", test $ W.splitDrive "/d" == ("", "/d"))
    ,("P.splitDrive \"/test\" == (\"/\", \"test\")", test $ P.splitDrive "/test" == ("/", "test"))
    ,("P.splitDrive \"//test\" == (\"//\", \"test\")", test $ P.splitDrive "//test" == ("//", "test"))
    ,("P.splitDrive \"test/file\" == (\"\", \"test/file\")", test $ P.splitDrive "test/file" == ("", "test/file"))
    ,("P.splitDrive \"file\" == (\"\", \"file\")", test $ P.splitDrive "file" == ("", "file"))
    ,("uncurry P.joinDrive (P.splitDrive x) == x", test $ \(QFilePathValidP x) -> uncurry P.joinDrive (P.splitDrive x) == x)
    ,("uncurry W.joinDrive (W.splitDrive x) == x", test $ \(QFilePathValidW x) -> uncurry W.joinDrive (W.splitDrive x) == x)
    ,("W.joinDrive \"C:\" \"foo\" == \"C:foo\"", test $ W.joinDrive "C:" "foo" == "C:foo")
    ,("W.joinDrive \"C:\\\\\" \"bar\" == \"C:\\\\bar\"", test $ W.joinDrive "C:\\" "bar" == "C:\\bar")
    ,("W.joinDrive \"\\\\\\\\share\" \"foo\" == \"\\\\\\\\share\\\\foo\"", test $ W.joinDrive "\\\\share" "foo" == "\\\\share\\foo")
    ,("W.joinDrive \"/:\" \"foo\" == \"/:\\\\foo\"", test $ W.joinDrive "/:" "foo" == "/:\\foo")
    ,("P.takeDrive x == fst (P.splitDrive x)", test $ \(QFilePath x) -> P.takeDrive x == fst (P.splitDrive x))
    ,("W.takeDrive x == fst (W.splitDrive x)", test $ \(QFilePath x) -> W.takeDrive x == fst (W.splitDrive x))
    ,("P.dropDrive x == snd (P.splitDrive x)", test $ \(QFilePath x) -> P.dropDrive x == snd (P.splitDrive x))
    ,("W.dropDrive x == snd (W.splitDrive x)", test $ \(QFilePath x) -> W.dropDrive x == snd (W.splitDrive x))
    ,("not (P.hasDrive x) == null (P.takeDrive x)", test $ \(QFilePath x) -> not (P.hasDrive x) == null (P.takeDrive x))
    ,("not (W.hasDrive x) == null (W.takeDrive x)", test $ \(QFilePath x) -> not (W.hasDrive x) == null (W.takeDrive x))
    ,("P.hasDrive \"/foo\" == True", test $ P.hasDrive "/foo" == True)
    ,("W.hasDrive \"C:\\\\foo\" == True", test $ W.hasDrive "C:\\foo" == True)
    ,("W.hasDrive \"C:foo\" == True", test $ W.hasDrive "C:foo" == True)
    ,("P.hasDrive \"foo\" == False", test $ P.hasDrive "foo" == False)
    ,("W.hasDrive \"foo\" == False", test $ W.hasDrive "foo" == False)
    ,("P.hasDrive \"\" == False", test $ P.hasDrive "" == False)
    ,("W.hasDrive \"\" == False", test $ W.hasDrive "" == False)
    ,("P.isDrive \"/\" == True", test $ P.isDrive "/" == True)
    ,("P.isDrive \"/foo\" == False", test $ P.isDrive "/foo" == False)
    ,("W.isDrive \"C:\\\\\" == True", test $ W.isDrive "C:\\" == True)
    ,("W.isDrive \"C:\\\\foo\" == False", test $ W.isDrive "C:\\foo" == False)
    ,("P.isDrive \"\" == False", test $ P.isDrive "" == False)
    ,("W.isDrive \"\" == False", test $ W.isDrive "" == False)
    ,("uncurry (P.</>) (P.splitFileName x) == x || fst (P.splitFileName x) == \"./\"", test $ \(QFilePathValidP x) -> uncurry (P.</>) (P.splitFileName x) == x || fst (P.splitFileName x) == "./")
    ,("uncurry (W.</>) (W.splitFileName x) == x || fst (W.splitFileName x) == \"./\"", test $ \(QFilePathValidW x) -> uncurry (W.</>) (W.splitFileName x) == x || fst (W.splitFileName x) == "./")
    ,("P.isValid (fst (P.splitFileName x))", test $ \(QFilePathValidP x) -> P.isValid (fst (P.splitFileName x)))
    ,("W.isValid (fst (W.splitFileName x))", test $ \(QFilePathValidW x) -> W.isValid (fst (W.splitFileName x)))
    ,("P.splitFileName \"file/bob.txt\" == (\"file/\", \"bob.txt\")", test $ P.splitFileName "file/bob.txt" == ("file/", "bob.txt"))
    ,("W.splitFileName \"file/bob.txt\" == (\"file/\", \"bob.txt\")", test $ W.splitFileName "file/bob.txt" == ("file/", "bob.txt"))
    ,("P.splitFileName \"file/\" == (\"file/\", \"\")", test $ P.splitFileName "file/" == ("file/", ""))
    ,("W.splitFileName \"file/\" == (\"file/\", \"\")", test $ W.splitFileName "file/" == ("file/", ""))
    ,("P.splitFileName \"bob\" == (\"./\", \"bob\")", test $ P.splitFileName "bob" == ("./", "bob"))
    ,("W.splitFileName \"bob\" == (\"./\", \"bob\")", test $ W.splitFileName "bob" == ("./", "bob"))
    ,("P.splitFileName \"/\" == (\"/\", \"\")", test $ P.splitFileName "/" == ("/", ""))
    ,("W.splitFileName \"c:\" == (\"c:\", \"\")", test $ W.splitFileName "c:" == ("c:", ""))
    ,("P.replaceFileName x (P.takeFileName x) == x", test $ \(QFilePathValidP x) -> P.replaceFileName x (P.takeFileName x) == x)
    ,("W.replaceFileName x (W.takeFileName x) == x", test $ \(QFilePathValidW x) -> W.replaceFileName x (W.takeFileName x) == x)
    ,("P.dropFileName x == fst (P.splitFileName x)", test $ \(QFilePath x) -> P.dropFileName x == fst (P.splitFileName x))
    ,("W.dropFileName x == fst (W.splitFileName x)", test $ \(QFilePath x) -> W.dropFileName x == fst (W.splitFileName x))
    ,("P.takeFileName \"test/\" == \"\"", test $ P.takeFileName "test/" == "")
    ,("W.takeFileName \"test/\" == \"\"", test $ W.takeFileName "test/" == "")
    ,("P.takeFileName x `isSuffixOf` x", test $ \(QFilePath x) -> P.takeFileName x `isSuffixOf` x)
    ,("W.takeFileName x `isSuffixOf` x", test $ \(QFilePath x) -> W.takeFileName x `isSuffixOf` x)
    ,("P.takeFileName x == snd (P.splitFileName x)", test $ \(QFilePath x) -> P.takeFileName x == snd (P.splitFileName x))
    ,("W.takeFileName x == snd (W.splitFileName x)", test $ \(QFilePath x) -> W.takeFileName x == snd (W.splitFileName x))
    ,("P.takeFileName (P.replaceFileName x \"fred\") == \"fred\"", test $ \(QFilePathValidP x) -> P.takeFileName (P.replaceFileName x "fred") == "fred")
    ,("W.takeFileName (W.replaceFileName x \"fred\") == \"fred\"", test $ \(QFilePathValidW x) -> W.takeFileName (W.replaceFileName x "fred") == "fred")
    ,("P.takeFileName (x P.</> \"fred\") == \"fred\"", test $ \(QFilePathValidP x) -> P.takeFileName (x P.</> "fred") == "fred")
    ,("W.takeFileName (x W.</> \"fred\") == \"fred\"", test $ \(QFilePathValidW x) -> W.takeFileName (x W.</> "fred") == "fred")
    ,("P.isRelative (P.takeFileName x)", test $ \(QFilePathValidP x) -> P.isRelative (P.takeFileName x))
    ,("W.isRelative (W.takeFileName x)", test $ \(QFilePathValidW x) -> W.isRelative (W.takeFileName x))
    ,("P.takeBaseName \"file/test.txt\" == \"test\"", test $ P.takeBaseName "file/test.txt" == "test")
    ,("W.takeBaseName \"file/test.txt\" == \"test\"", test $ W.takeBaseName "file/test.txt" == "test")
    ,("P.takeBaseName \"dave.ext\" == \"dave\"", test $ P.takeBaseName "dave.ext" == "dave")
    ,("W.takeBaseName \"dave.ext\" == \"dave\"", test $ W.takeBaseName "dave.ext" == "dave")
    ,("P.takeBaseName \"\" == \"\"", test $ P.takeBaseName "" == "")
    ,("W.takeBaseName \"\" == \"\"", test $ W.takeBaseName "" == "")
    ,("P.takeBaseName \"test\" == \"test\"", test $ P.takeBaseName "test" == "test")
    ,("W.takeBaseName \"test\" == \"test\"", test $ W.takeBaseName "test" == "test")
    ,("P.takeBaseName (P.addTrailingPathSeparator x) == \"\"", test $ \(QFilePath x) -> P.takeBaseName (P.addTrailingPathSeparator x) == "")
    ,("W.takeBaseName (W.addTrailingPathSeparator x) == \"\"", test $ \(QFilePath x) -> W.takeBaseName (W.addTrailingPathSeparator x) == "")
    ,("P.takeBaseName \"file/file.tar.gz\" == \"file.tar\"", test $ P.takeBaseName "file/file.tar.gz" == "file.tar")
    ,("W.takeBaseName \"file/file.tar.gz\" == \"file.tar\"", test $ W.takeBaseName "file/file.tar.gz" == "file.tar")
    ,("P.replaceBaseName \"file/test.txt\" \"bob\" == \"file/bob.txt\"", test $ P.replaceBaseName "file/test.txt" "bob" == "file/bob.txt")
    ,("W.replaceBaseName \"file/test.txt\" \"bob\" == \"file/bob.txt\"", test $ W.replaceBaseName "file/test.txt" "bob" == "file/bob.txt")
    ,("P.replaceBaseName \"fred\" \"bill\" == \"bill\"", test $ P.replaceBaseName "fred" "bill" == "bill")
    ,("W.replaceBaseName \"fred\" \"bill\" == \"bill\"", test $ W.replaceBaseName "fred" "bill" == "bill")
    ,("P.replaceBaseName \"/dave/fred/bob.gz.tar\" \"new\" == \"/dave/fred/new.tar\"", test $ P.replaceBaseName "/dave/fred/bob.gz.tar" "new" == "/dave/fred/new.tar")
    ,("W.replaceBaseName \"/dave/fred/bob.gz.tar\" \"new\" == \"/dave/fred/new.tar\"", test $ W.replaceBaseName "/dave/fred/bob.gz.tar" "new" == "/dave/fred/new.tar")
    ,("P.replaceBaseName x (P.takeBaseName x) == x", test $ \(QFilePathValidP x) -> P.replaceBaseName x (P.takeBaseName x) == x)
    ,("W.replaceBaseName x (W.takeBaseName x) == x", test $ \(QFilePathValidW x) -> W.replaceBaseName x (W.takeBaseName x) == x)
    ,("P.hasTrailingPathSeparator \"test\" == False", test $ P.hasTrailingPathSeparator "test" == False)
    ,("W.hasTrailingPathSeparator \"test\" == False", test $ W.hasTrailingPathSeparator "test" == False)
    ,("P.hasTrailingPathSeparator \"test/\" == True", test $ P.hasTrailingPathSeparator "test/" == True)
    ,("W.hasTrailingPathSeparator \"test/\" == True", test $ W.hasTrailingPathSeparator "test/" == True)
    ,("P.hasTrailingPathSeparator (P.addTrailingPathSeparator x)", test $ \(QFilePath x) -> P.hasTrailingPathSeparator (P.addTrailingPathSeparator x))
    ,("W.hasTrailingPathSeparator (W.addTrailingPathSeparator x)", test $ \(QFilePath x) -> W.hasTrailingPathSeparator (W.addTrailingPathSeparator x))
    ,("P.hasTrailingPathSeparator x ==> P.addTrailingPathSeparator x == x", test $ \(QFilePath x) -> P.hasTrailingPathSeparator x ==> P.addTrailingPathSeparator x == x)
    ,("W.hasTrailingPathSeparator x ==> W.addTrailingPathSeparator x == x", test $ \(QFilePath x) -> W.hasTrailingPathSeparator x ==> W.addTrailingPathSeparator x == x)
    ,("P.addTrailingPathSeparator \"test/rest\" == \"test/rest/\"", test $ P.addTrailingPathSeparator "test/rest" == "test/rest/")
    ,("P.dropTrailingPathSeparator \"file/test/\" == \"file/test\"", test $ P.dropTrailingPathSeparator "file/test/" == "file/test")
    ,("W.dropTrailingPathSeparator \"file/test/\" == \"file/test\"", test $ W.dropTrailingPathSeparator "file/test/" == "file/test")
    ,("P.dropTrailingPathSeparator \"/\" == \"/\"", test $ P.dropTrailingPathSeparator "/" == "/")
    ,("W.dropTrailingPathSeparator \"/\" == \"/\"", test $ W.dropTrailingPathSeparator "/" == "/")
    ,("W.dropTrailingPathSeparator \"\\\\\" == \"\\\\\"", test $ W.dropTrailingPathSeparator "\\" == "\\")
    ,("not (P.hasTrailingPathSeparator (P.dropTrailingPathSeparator x)) || P.isDrive x", test $ \(QFilePath x) -> not (P.hasTrailingPathSeparator (P.dropTrailingPathSeparator x)) || P.isDrive x)
    ,("P.takeDirectory x `isPrefixOf` x || P.takeDirectory x == \".\"", test $ \(QFilePath x) -> P.takeDirectory x `isPrefixOf` x || P.takeDirectory x == ".")
    ,("W.takeDirectory x `isPrefixOf` x || W.takeDirectory x == \".\"", test $ \(QFilePath x) -> W.takeDirectory x `isPrefixOf` x || W.takeDirectory x == ".")
    ,("P.takeDirectory \"foo\" == \".\"", test $ P.takeDirectory "foo" == ".")
    ,("W.takeDirectory \"foo\" == \".\"", test $ W.takeDirectory "foo" == ".")
    ,("P.takeDirectory \"/\" == \"/\"", test $ P.takeDirectory "/" == "/")
    ,("W.takeDirectory \"/\" == \"/\"", test $ W.takeDirectory "/" == "/")
    ,("P.takeDirectory \"/foo\" == \"/\"", test $ P.takeDirectory "/foo" == "/")
    ,("W.takeDirectory \"/foo\" == \"/\"", test $ W.takeDirectory "/foo" == "/")
    ,("P.takeDirectory \"/foo/bar/baz\" == \"/foo/bar\"", test $ P.takeDirectory "/foo/bar/baz" == "/foo/bar")
    ,("W.takeDirectory \"/foo/bar/baz\" == \"/foo/bar\"", test $ W.takeDirectory "/foo/bar/baz" == "/foo/bar")
    ,("P.takeDirectory \"/foo/bar/baz/\" == \"/foo/bar/baz\"", test $ P.takeDirectory "/foo/bar/baz/" == "/foo/bar/baz")
    ,("W.takeDirectory \"/foo/bar/baz/\" == \"/foo/bar/baz\"", test $ W.takeDirectory "/foo/bar/baz/" == "/foo/bar/baz")
    ,("P.takeDirectory \"foo/bar/baz\" == \"foo/bar\"", test $ P.takeDirectory "foo/bar/baz" == "foo/bar")
    ,("W.takeDirectory \"foo/bar/baz\" == \"foo/bar\"", test $ W.takeDirectory "foo/bar/baz" == "foo/bar")
    ,("W.takeDirectory \"foo\\\\bar\" == \"foo\"", test $ W.takeDirectory "foo\\bar" == "foo")
    ,("W.takeDirectory \"foo\\\\bar\\\\\\\\\" == \"foo\\\\bar\"", test $ W.takeDirectory "foo\\bar\\\\" == "foo\\bar")
    ,("W.takeDirectory \"C:\\\\\" == \"C:\\\\\"", test $ W.takeDirectory "C:\\" == "C:\\")
    ,("P.replaceDirectory x (P.takeDirectory x) `P.equalFilePath` x", test $ \(QFilePathValidP x) -> P.replaceDirectory x (P.takeDirectory x) `P.equalFilePath` x)
    ,("W.replaceDirectory x (W.takeDirectory x) `W.equalFilePath` x", test $ \(QFilePathValidW x) -> W.replaceDirectory x (W.takeDirectory x) `W.equalFilePath` x)
    ,("P.combine (P.takeDirectory x) (P.takeFileName x) `P.equalFilePath` x", test $ \(QFilePathValidP x) -> P.combine (P.takeDirectory x) (P.takeFileName x) `P.equalFilePath` x)
    ,("W.combine (W.takeDirectory x) (W.takeFileName x) `W.equalFilePath` x", test $ \(QFilePathValidW x) -> W.combine (W.takeDirectory x) (W.takeFileName x) `W.equalFilePath` x)
    ,("P.combine \"/\" \"test\" == \"/test\"", test $ P.combine "/" "test" == "/test")
    ,("P.combine \"home\" \"bob\" == \"home/bob\"", test $ P.combine "home" "bob" == "home/bob")
    ,("P.combine \"x:\" \"foo\" == \"x:/foo\"", test $ P.combine "x:" "foo" == "x:/foo")
    ,("W.combine \"C:\\\\foo\" \"bar\" == \"C:\\\\foo\\\\bar\"", test $ W.combine "C:\\foo" "bar" == "C:\\foo\\bar")
    ,("W.combine \"home\" \"bob\" == \"home\\\\bob\"", test $ W.combine "home" "bob" == "home\\bob")
    ,("P.combine \"home\" \"/bob\" == \"/bob\"", test $ P.combine "home" "/bob" == "/bob")
    ,("W.combine \"home\" \"C:\\\\bob\" == \"C:\\\\bob\"", test $ W.combine "home" "C:\\bob" == "C:\\bob")
    ,("W.combine \"home\" \"/bob\" == \"/bob\"", test $ W.combine "home" "/bob" == "/bob")
    ,("W.combine \"home\" \"\\\\bob\" == \"\\\\bob\"", test $ W.combine "home" "\\bob" == "\\bob")
    ,("W.combine \"C:\\\\home\" \"\\\\bob\" == \"\\\\bob\"", test $ W.combine "C:\\home" "\\bob" == "\\bob")
    ,("W.combine \"D:\\\\foo\" \"C:bar\" == \"C:bar\"", test $ W.combine "D:\\foo" "C:bar" == "C:bar")
    ,("W.combine \"C:\\\\foo\" \"C:bar\" == \"C:bar\"", test $ W.combine "C:\\foo" "C:bar" == "C:bar")
    ,("concat (P.splitPath x) == x", test $ \(QFilePath x) -> concat (P.splitPath x) == x)
    ,("concat (W.splitPath x) == x", test $ \(QFilePath x) -> concat (W.splitPath x) == x)
    ,("P.splitPath \"test//item/\" == [\"test//\", \"item/\"]", test $ P.splitPath "test//item/" == ["test//", "item/"])
    ,("W.splitPath \"test//item/\" == [\"test//\", \"item/\"]", test $ W.splitPath "test//item/" == ["test//", "item/"])
    ,("P.splitPath \"test/item/file\" == [\"test/\", \"item/\", \"file\"]", test $ P.splitPath "test/item/file" == ["test/", "item/", "file"])
    ,("W.splitPath \"test/item/file\" == [\"test/\", \"item/\", \"file\"]", test $ W.splitPath "test/item/file" == ["test/", "item/", "file"])
    ,("P.splitPath \"\" == []", test $ P.splitPath "" == [])
    ,("W.splitPath \"\" == []", test $ W.splitPath "" == [])
    ,("W.splitPath \"c:\\\\test\\\\path\" == [\"c:\\\\\", \"test\\\\\", \"path\"]", test $ W.splitPath "c:\\test\\path" == ["c:\\", "test\\", "path"])
    ,("P.splitPath \"/file/test\" == [\"/\", \"file/\", \"test\"]", test $ P.splitPath "/file/test" == ["/", "file/", "test"])
    ,("P.splitDirectories \"test/file\" == [\"test\", \"file\"]", test $ P.splitDirectories "test/file" == ["test", "file"])
    ,("W.splitDirectories \"test/file\" == [\"test\", \"file\"]", test $ W.splitDirectories "test/file" == ["test", "file"])
    ,("P.splitDirectories \"/test/file\" == [\"/\", \"test\", \"file\"]", test $ P.splitDirectories "/test/file" == ["/", "test", "file"])
    ,("W.splitDirectories \"/test/file\" == [\"/\", \"test\", \"file\"]", test $ W.splitDirectories "/test/file" == ["/", "test", "file"])
    ,("W.splitDirectories \"C:\\\\test\\\\file\" == [\"C:\\\\\", \"test\", \"file\"]", test $ W.splitDirectories "C:\\test\\file" == ["C:\\", "test", "file"])
    ,("P.joinPath (P.splitDirectories x) `P.equalFilePath` x", test $ \(QFilePathValidP x) -> P.joinPath (P.splitDirectories x) `P.equalFilePath` x)
    ,("W.joinPath (W.splitDirectories x) `W.equalFilePath` x", test $ \(QFilePathValidW x) -> W.joinPath (W.splitDirectories x) `W.equalFilePath` x)
    ,("P.splitDirectories \"\" == []", test $ P.splitDirectories "" == [])
    ,("W.splitDirectories \"\" == []", test $ W.splitDirectories "" == [])
    ,("W.splitDirectories \"C:\\\\test\\\\\\\\\\\\file\" == [\"C:\\\\\", \"test\", \"file\"]", test $ W.splitDirectories "C:\\test\\\\\\file" == ["C:\\", "test", "file"])
    ,("P.splitDirectories \"/test///file\" == [\"/\", \"test\", \"file\"]", test $ P.splitDirectories "/test///file" == ["/", "test", "file"])
    ,("W.splitDirectories \"/test///file\" == [\"/\", \"test\", \"file\"]", test $ W.splitDirectories "/test///file" == ["/", "test", "file"])
    ,("P.joinPath (P.splitPath x) == x", test $ \(QFilePathValidP x) -> P.joinPath (P.splitPath x) == x)
    ,("W.joinPath (W.splitPath x) == x", test $ \(QFilePathValidW x) -> W.joinPath (W.splitPath x) == x)
    ,("P.joinPath [] == \"\"", test $ P.joinPath [] == "")
    ,("W.joinPath [] == \"\"", test $ W.joinPath [] == "")
    ,("P.joinPath [\"test\", \"file\", \"path\"] == \"test/file/path\"", test $ P.joinPath ["test", "file", "path"] == "test/file/path")
    ,("x == y ==> P.equalFilePath x y", test $ \(QFilePath x) (QFilePath y) -> x == y ==> P.equalFilePath x y)
    ,("x == y ==> W.equalFilePath x y", test $ \(QFilePath x) (QFilePath y) -> x == y ==> W.equalFilePath x y)
    ,("P.normalise x == P.normalise y ==> P.equalFilePath x y", test $ \(QFilePath x) (QFilePath y) -> P.normalise x == P.normalise y ==> P.equalFilePath x y)
    ,("W.normalise x == W.normalise y ==> W.equalFilePath x y", test $ \(QFilePath x) (QFilePath y) -> W.normalise x == W.normalise y ==> W.equalFilePath x y)
    ,("P.equalFilePath \"foo\" \"foo/\"", test $ P.equalFilePath "foo" "foo/")
    ,("W.equalFilePath \"foo\" \"foo/\"", test $ W.equalFilePath "foo" "foo/")
    ,("not (P.equalFilePath \"foo\" \"/foo\")", test $ not (P.equalFilePath "foo" "/foo"))
    ,("not (W.equalFilePath \"foo\" \"/foo\")", test $ not (W.equalFilePath "foo" "/foo"))
    ,("not (P.equalFilePath \"foo\" \"FOO\")", test $ not (P.equalFilePath "foo" "FOO"))
    ,("W.equalFilePath \"foo\" \"FOO\"", test $ W.equalFilePath "foo" "FOO")
    ,("not (W.equalFilePath \"C:\" \"C:/\")", test $ not (W.equalFilePath "C:" "C:/"))
    ,("P.equalFilePath x y || (P.isRelative x && P.makeRelative y x == x) || P.equalFilePath (y P.</> P.makeRelative y x) x", test $ \(QFilePathValidP x) (QFilePathValidP y) -> P.equalFilePath x y || (P.isRelative x && P.makeRelative y x == x) || P.equalFilePath (y P.</> P.makeRelative y x) x)
    ,("W.equalFilePath x y || (W.isRelative x && W.makeRelative y x == x) || W.equalFilePath (y W.</> W.makeRelative y x) x", test $ \(QFilePathValidW x) (QFilePathValidW y) -> W.equalFilePath x y || (W.isRelative x && W.makeRelative y x == x) || W.equalFilePath (y W.</> W.makeRelative y x) x)
    ,("P.makeRelative x x == \".\"", test $ \(QFilePath x) -> P.makeRelative x x == ".")
    ,("W.makeRelative x x == \".\"", test $ \(QFilePath x) -> W.makeRelative x x == ".")
    ,("W.makeRelative \"C:\\\\Home\" \"c:\\\\home\\\\bob\" == \"bob\"", test $ W.makeRelative "C:\\Home" "c:\\home\\bob" == "bob")
    ,("W.makeRelative \"C:\\\\Home\" \"c:/home/bob\" == \"bob\"", test $ W.makeRelative "C:\\Home" "c:/home/bob" == "bob")
    ,("W.makeRelative \"C:\\\\Home\" \"D:\\\\Home\\\\Bob\" == \"D:\\\\Home\\\\Bob\"", test $ W.makeRelative "C:\\Home" "D:\\Home\\Bob" == "D:\\Home\\Bob")
    ,("W.makeRelative \"C:\\\\Home\" \"C:Home\\\\Bob\" == \"C:Home\\\\Bob\"", test $ W.makeRelative "C:\\Home" "C:Home\\Bob" == "C:Home\\Bob")
    ,("W.makeRelative \"/Home\" \"/home/bob\" == \"bob\"", test $ W.makeRelative "/Home" "/home/bob" == "bob")
    ,("W.makeRelative \"/\" \"//\" == \"//\"", test $ W.makeRelative "/" "//" == "//")
    ,("P.makeRelative \"/Home\" \"/home/bob\" == \"/home/bob\"", test $ P.makeRelative "/Home" "/home/bob" == "/home/bob")
    ,("P.makeRelative \"/home/\" \"/home/bob/foo/bar\" == \"bob/foo/bar\"", test $ P.makeRelative "/home/" "/home/bob/foo/bar" == "bob/foo/bar")
    ,("P.makeRelative \"/fred\" \"bob\" == \"bob\"", test $ P.makeRelative "/fred" "bob" == "bob")
    ,("P.makeRelative \"/file/test\" \"/file/test/fred\" == \"fred\"", test $ P.makeRelative "/file/test" "/file/test/fred" == "fred")
    ,("P.makeRelative \"/file/test\" \"/file/test/fred/\" == \"fred/\"", test $ P.makeRelative "/file/test" "/file/test/fred/" == "fred/")
    ,("P.makeRelative \"some/path\" \"some/path/a/b/c\" == \"a/b/c\"", test $ P.makeRelative "some/path" "some/path/a/b/c" == "a/b/c")
    ,("P.normalise \"/file/\\\\test////\" == \"/file/\\\\test/\"", test $ P.normalise "/file/\\test////" == "/file/\\test/")
    ,("P.normalise \"/file/./test\" == \"/file/test\"", test $ P.normalise "/file/./test" == "/file/test")
    ,("P.normalise \"/test/file/../bob/fred/\" == \"/test/file/../bob/fred/\"", test $ P.normalise "/test/file/../bob/fred/" == "/test/file/../bob/fred/")
    ,("P.normalise \"../bob/fred/\" == \"../bob/fred/\"", test $ P.normalise "../bob/fred/" == "../bob/fred/")
    ,("P.normalise \"./bob/fred/\" == \"bob/fred/\"", test $ P.normalise "./bob/fred/" == "bob/fred/")
    ,("W.normalise \"c:\\\\file/bob\\\\\" == \"C:\\\\file\\\\bob\\\\\"", test $ W.normalise "c:\\file/bob\\" == "C:\\file\\bob\\")
    ,("W.normalise \"c:\\\\\" == \"C:\\\\\"", test $ W.normalise "c:\\" == "C:\\")
    ,("W.normalise \"C:.\\\\\" == \"C:\"", test $ W.normalise "C:.\\" == "C:")
    ,("W.normalise \"\\\\\\\\server\\\\test\" == \"\\\\\\\\server\\\\test\"", test $ W.normalise "\\\\server\\test" == "\\\\server\\test")
    ,("W.normalise \"//server/test\" == \"\\\\\\\\server\\\\test\"", test $ W.normalise "//server/test" == "\\\\server\\test")
    ,("W.normalise \"c:/file\" == \"C:\\\\file\"", test $ W.normalise "c:/file" == "C:\\file")
    ,("W.normalise \"/file\" == \"\\\\file\"", test $ W.normalise "/file" == "\\file")
    ,("W.normalise \"\\\\\" == \"\\\\\"", test $ W.normalise "\\" == "\\")
    ,("W.normalise \"/./\" == \"\\\\\"", test $ W.normalise "/./" == "\\")
    ,("P.normalise \".\" == \".\"", test $ P.normalise "." == ".")
    ,("W.normalise \".\" == \".\"", test $ W.normalise "." == ".")
    ,("P.normalise \"./\" == \"./\"", test $ P.normalise "./" == "./")
    ,("P.normalise \"./.\" == \"./\"", test $ P.normalise "./." == "./")
    ,("P.normalise \"/./\" == \"/\"", test $ P.normalise "/./" == "/")
    ,("P.normalise \"/\" == \"/\"", test $ P.normalise "/" == "/")
    ,("P.normalise \"bob/fred/.\" == \"bob/fred/\"", test $ P.normalise "bob/fred/." == "bob/fred/")
    ,("P.normalise \"//home\" == \"/home\"", test $ P.normalise "//home" == "/home")
    ,("P.isValid \"\" == False", test $ P.isValid "" == False)
    ,("W.isValid \"\" == False", test $ W.isValid "" == False)
    ,("P.isValid \"/random_ path:*\" == True", test $ P.isValid "/random_ path:*" == True)
    ,("P.isValid x == not (null x)", test $ \(QFilePath x) -> P.isValid x == not (null x))
    ,("W.isValid \"c:\\\\test\" == True", test $ W.isValid "c:\\test" == True)
    ,("W.isValid \"c:\\\\test:of_test\" == False", test $ W.isValid "c:\\test:of_test" == False)
    ,("W.isValid \"test*\" == False", test $ W.isValid "test*" == False)
    ,("W.isValid \"c:\\\\test\\\\nul\" == False", test $ W.isValid "c:\\test\\nul" == False)
    ,("W.isValid \"c:\\\\test\\\\prn.txt\" == False", test $ W.isValid "c:\\test\\prn.txt" == False)
    ,("W.isValid \"c:\\\\nul\\\\file\" == False", test $ W.isValid "c:\\nul\\file" == False)
    ,("W.isValid \"\\\\\\\\\" == False", test $ W.isValid "\\\\" == False)
    ,("W.isValid \"\\\\\\\\\\\\foo\" == False", test $ W.isValid "\\\\\\foo" == False)
    ,("W.isValid \"\\\\\\\\?\\\\D:file\" == False", test $ W.isValid "\\\\?\\D:file" == False)
    ,("P.isValid (P.makeValid x)", test $ \(QFilePath x) -> P.isValid (P.makeValid x))
    ,("W.isValid (W.makeValid x)", test $ \(QFilePath x) -> W.isValid (W.makeValid x))
    ,("P.isValid x ==> P.makeValid x == x", test $ \(QFilePath x) -> P.isValid x ==> P.makeValid x == x)
    ,("W.isValid x ==> W.makeValid x == x", test $ \(QFilePath x) -> W.isValid x ==> W.makeValid x == x)
    ,("P.makeValid \"\" == \"_\"", test $ P.makeValid "" == "_")
    ,("W.makeValid \"\" == \"_\"", test $ W.makeValid "" == "_")
    ,("W.makeValid \"c:\\\\already\\\\/valid\" == \"c:\\\\already\\\\/valid\"", test $ W.makeValid "c:\\already\\/valid" == "c:\\already\\/valid")
    ,("W.makeValid \"c:\\\\test:of_test\" == \"c:\\\\test_of_test\"", test $ W.makeValid "c:\\test:of_test" == "c:\\test_of_test")
    ,("W.makeValid \"test*\" == \"test_\"", test $ W.makeValid "test*" == "test_")
    ,("W.makeValid \"c:\\\\test\\\\nul\" == \"c:\\\\test\\\\nul_\"", test $ W.makeValid "c:\\test\\nul" == "c:\\test\\nul_")
    ,("W.makeValid \"c:\\\\test\\\\prn.txt\" == \"c:\\\\test\\\\prn_.txt\"", test $ W.makeValid "c:\\test\\prn.txt" == "c:\\test\\prn_.txt")
    ,("W.makeValid \"c:\\\\test/prn.txt\" == \"c:\\\\test/prn_.txt\"", test $ W.makeValid "c:\\test/prn.txt" == "c:\\test/prn_.txt")
    ,("W.makeValid \"c:\\\\nul\\\\file\" == \"c:\\\\nul_\\\\file\"", test $ W.makeValid "c:\\nul\\file" == "c:\\nul_\\file")
    ,("W.makeValid \"\\\\\\\\\\\\foo\" == \"\\\\\\\\drive\"", test $ W.makeValid "\\\\\\foo" == "\\\\drive")
    ,("W.makeValid \"\\\\\\\\?\\\\D:file\" == \"\\\\\\\\?\\\\D:\\\\file\"", test $ W.makeValid "\\\\?\\D:file" == "\\\\?\\D:\\file")
    ,("W.isRelative \"path\\\\test\" == True", test $ W.isRelative "path\\test" == True)
    ,("W.isRelative \"c:\\\\test\" == False", test $ W.isRelative "c:\\test" == False)
    ,("W.isRelative \"c:test\" == True", test $ W.isRelative "c:test" == True)
    ,("W.isRelative \"c:\\\\\" == False", test $ W.isRelative "c:\\" == False)
    ,("W.isRelative \"c:/\" == False", test $ W.isRelative "c:/" == False)
    ,("W.isRelative \"c:\" == True", test $ W.isRelative "c:" == True)
    ,("W.isRelative \"\\\\\\\\foo\" == False", test $ W.isRelative "\\\\foo" == False)
    ,("W.isRelative \"\\\\\\\\?\\\\foo\" == False", test $ W.isRelative "\\\\?\\foo" == False)
    ,("W.isRelative \"\\\\\\\\?\\\\UNC\\\\foo\" == False", test $ W.isRelative "\\\\?\\UNC\\foo" == False)
    ,("W.isRelative \"/foo\" == True", test $ W.isRelative "/foo" == True)
    ,("W.isRelative \"\\\\foo\" == True", test $ W.isRelative "\\foo" == True)
    ,("P.isRelative \"test/path\" == True", test $ P.isRelative "test/path" == True)
    ,("P.isRelative \"/test\" == False", test $ P.isRelative "/test" == False)
    ,("P.isRelative \"/\" == False", test $ P.isRelative "/" == False)
    ,("P.isAbsolute x == not (P.isRelative x)", test $ \(QFilePath x) -> P.isAbsolute x == not (P.isRelative x))
    ,("W.isAbsolute x == not (W.isRelative x)", test $ \(QFilePath x) -> W.isAbsolute x == not (W.isRelative x))
    ]

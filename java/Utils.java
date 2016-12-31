package eta.filepath;

public class Utils {
    public static boolean isWindows() {
        String osName = System.getProperty("os.name");
        return osName.startsWith("Windows");
    }
}

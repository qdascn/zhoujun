package cn.qdas;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Objects;

import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.ArchiveInputStream;
import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;

public class ZipTest {
    public static void unzip(String zipFileName, String destDir) {
        try (InputStream fis = Files.newInputStream(Paths.get(zipFileName));
             InputStream bis = new BufferedInputStream(fis);
             ArchiveInputStream ais = new ZipArchiveInputStream(bis)) {

            ArchiveEntry entry;
            while (Objects.nonNull(entry = ais.getNextEntry())) {
                if (!ais.canReadEntryData(entry)) {
                    continue;
                }

                String name = filename(destDir, entry.getName());
                File f = new File(name);
                if (entry.isDirectory()) {
                    if (!f.isDirectory() && !f.mkdirs()) {
                        f.mkdirs();
                    }
                } else {
                    File parent = f.getParentFile();
                    if (!parent.isDirectory() && !parent.mkdirs()) {
                        throw new IOException("failed to create directory " + parent);
                    }
                    try (OutputStream o = Files.newOutputStream(f.toPath())) {
                        IOUtils.copy(ais, o);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String filename(String destDir, String name) {
        return destDir + File.separator + name;
    }
    public static void main(String[] args) {
		unzip("F:\\backup\\001532++F01R10P878++高压燃油分配管++02++WXP2QMP2++WXP2.zip", "F:\\backup");
	}
}

package com.fh.util;

import java.io.File;
import java.io.IOException;

import net.coobird.thumbnailator.Thumbnails;

public class ImgUpload {

	public static void zoomImageScale(File imageFile, String newPath,
			int newWidth) throws IOException {
		Thumbnails.of(new File[] { imageFile }).scale(0.5D).outputFormat("png")
				.toFile(newPath);
	}

	public static void main(String[] args) throws IOException {
		zoomImageScale(
				new File(
						"D:\\apache-tomcat-8.0.30\\webapps\\cbw\\upload\\image\\ec38605a-6e7f-4091-8d61-abe6af3ec307.png"),
				"D:\\img\\5.png", 400);
	}
}

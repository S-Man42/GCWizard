package Servlet;

import org.apache.tomcat.jakartaee.commons.compress.utils.FileNameUtils;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.impl.SizeLimitExceededException;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.util.List;
import java.util.concurrent.TimeUnit;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UnluacServlet
 */
@WebServlet("")
public class UnluacServlet extends HttpServlet {
	// From 'https://github.com/HansWessels/unluac'
	private static String unluacJarPath = "";
	private static String outputPath = "";
	final private static String scriptTemplate = "java -jar %s %s > %s";
	
	final private static String OS = System.getProperty("os.name").toLowerCase();
	final private static boolean IS_WINDOWS = OS.contains("windows");
	
	private static final long serialVersionUID = 1L;
	
	public UnluacServlet() {
		super();
	}
	
	/**
	 * @throws IOException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		try {
			if (ServletFileUpload.isMultipartContent(req)) {			
				// Set paths
				final String servletCtxPath = this.getServletContext().getRealPath("");
				final String uploadPath = servletCtxPath + "Uploads" + File.separator;
				outputPath = servletCtxPath + "Output" + File.separator;
		
				try {
					unluacJarPath = getClass().getClassLoader().getResource("unluac.jar").toURI().getPath().substring(1);
				} catch (URISyntaxException e) {
					System.err.printf("URISyntaxException:: %s\n", e.getMessage());
					buildErrorResponse("wherigo_http_code_500_detail_access", 500, res);
					return;
				}
				
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// Write all to disk
				factory.setSizeThreshold(0);
				// Write to temp directory
				factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
				
				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);
				
				// Set overall request size constraint (2,5MB)
				upload.setSizeMax(2500000);
	
				List<FileItem> fileItems = null;
				// Parse request
				try {
					fileItems = upload.parseRequest(new ServletRequestContext(req));
				} catch (SizeLimitExceededException e) {
					System.err.println("SizeLimitExceededException::" + e.getMessage());
					buildErrorResponse("wherigo_http_code_413_detail_size", 413, res);
					return;
				} catch (FileUploadException e) {
					System.err.println("FileUploadException::" + e.getMessage());
					buildErrorResponse("wherigo_http_code_400_detail_extract", 400, res);
					return;
				}
				
				// Should only be one file, so only consider first in list
				FileItem submittedFile = fileItems.get(0);
	
				// Check if upload directory exists
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) uploadDir.mkdir();
				
				// Set fileName
				String uploadFileName = String.valueOf(System.currentTimeMillis()) + ".luac"; 
				File uploadedFile = new File(uploadPath + uploadFileName);
							
				// Save .luac file
				try {
					submittedFile.write(uploadedFile);
				} catch (Exception e) {
					System.err.println("Exception:: " + e.getMessage() + "\nCould not write LUA Bytecode to disk");
					buildErrorResponse("wherigo_http_code_500_detail_write", 500, res);
					return;
				}
				
				File result = null;
				BufferedReader reader = null;
				try {
					final String fileName = FileNameUtils.getBaseName(uploadedFile.getName());
					
					// Check if output directory exists
					File resultDir = new File(outputPath);
					if (!resultDir.exists()) resultDir.mkdir();
		
					// Generate output file path
					final String resultPath = outputPath + fileName + ".txt";
					
					// Try to execute unluac.jar with received file
					try {
						executeScript(uploadedFile, resultPath);
					} catch (IOException e) {
						System.err.println("IOException:: " + e.getMessage());
						buildErrorResponse("wherigo_http_code_500_detail_process", 500, res);
						return;
					} catch (InterruptedException e) {
						System.err.printf("InterruptedException:: " + e.getMessage());
						buildErrorResponse("wherigo_http_code_500_detail_interrupt", 500, res);
						return;
					}

					result = new File(resultPath);
					reader = new BufferedReader(new FileReader(result));
					PrintWriter w = res.getWriter();
					String line = reader.readLine();
					
					// Check if result file is empty
					if (line == null) {
						System.err.println("LUA Sourcecode is empty");
						buildErrorResponse("wherigo_http_code_500_detail_empty", 500, res);
						return;
					}
					
					// Write result file content to response body
					while (line != null) {
						w.append(line + "\n");
						line = reader.readLine();
					}		

					//Send response
					res.setStatus(200);
					res.setContentType("text/plain");
					res.flushBuffer();

				} finally {
					// Cleanup
					reader.close();
					result.delete();
					uploadedFile.delete();
				}
			} else {
				System.err.println("Not a multipart request");
				buildErrorResponse("wherigo_http_code_400_detail_multipart", 400, res);
			}
		} catch (IOException e) {
			System.err.println("IOException 'detail_response':: " + e);
			throw new IOException("wherigo_http_code_500_detail_response");
		}
	}
	
	/**
	 * Builds and sends error response body
	 * @param message - to be sent back to client
	 * @param status - http status code
	 * @throws IOException 
	 */
	private static void buildErrorResponse(String message, int status, HttpServletResponse res) throws IOException {
		PrintWriter w = res.getWriter();
		w.append(message + "\n");
		res.setStatus(status);
		res.flushBuffer();
	}
	
	/**
	 * Executes unluac.jar to decompile a .luac file and save it to disk
	 * 
	 * @param file - .luac file
	 * @throws IOException
	 * @throws InterruptedException
	 */
	private static void executeScript(File file, String resultPath) throws IOException, InterruptedException {				
		// Create process to execute script
		ProcessBuilder pb = new ProcessBuilder();
				
		final String script = String.format(scriptTemplate,
				"\"" + unluacJarPath +"\"", "\"" + file.getAbsolutePath() + "\"", "\"" + resultPath + "\"");
		
		if (IS_WINDOWS) {
			pb.command("cmd.exe", "/c", script);
		} else {
			pb.command("/bin/bash", "-c", script);
		}
		Process p = pb.start();
		p.waitFor(120, TimeUnit.SECONDS);
		p.destroy();
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
		try {
			res.sendRedirect("https://gcwizard.net/#/");
		} catch (IOException e) {
			System.err.printf("IOException:: %s\n", e.getMessage());
			buildErrorResponse("Could not redirect to 'https://gcwizard.net/#/", 500, res);
		}
	}
	
	protected void doDelete(HttpServletRequest req, HttpServletResponse res) throws IOException {
		doGet(req, res);
	}
	
	protected void doPut(HttpServletRequest req, HttpServletResponse res) throws IOException {
		doGet(req, res);
	}
	
	protected void doHead(HttpServletRequest req, HttpServletResponse res) throws IOException {
		doGet(req, res);
	}
	
	protected void doOptions(HttpServletRequest req, HttpServletResponse res) throws IOException {
		doGet(req, res);
	}
	
	protected void doTrace(HttpServletRequest req, HttpServletResponse res) throws IOException {
		doGet(req, res);
	}
}

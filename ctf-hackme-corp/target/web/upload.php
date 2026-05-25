<?php
// =========================================================
// INTENTIONALLY VULNERABLE — CTF Challenge 5: File Upload RCE
// No file type validation — allows PHP execution
// DO NOT USE IN PRODUCTION
// =========================================================

$message = "";
$uploaded_path = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['file'])) {
    $file     = $_FILES['file'];
    $filename = basename($file['name']);   // no sanitisation
    $dest     = __DIR__ . '/uploads/' . $filename;

    if (move_uploaded_file($file['tmp_name'], $dest)) {
        $uploaded_path = '/uploads/' . $filename;
        $message = "success";
    } else {
        $message = "error";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>File Upload — HackMe Corp</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: Arial, sans-serif; background: #0d1117; color: #c9d1d9; min-height: 100vh; padding: 40px 20px; }
.container { max-width: 600px; margin: 0 auto; }
h2 { color: #e6edf3; margin-bottom: 8px; }
p.sub { color: #8b949e; font-size: 14px; margin-bottom: 24px; }
.upload-box { background: #161b22; border: 2px dashed #30363d; border-radius: 8px; padding: 40px; text-align: center; margin-bottom: 20px; }
.upload-box:hover { border-color: #58a6ff; }
input[type=file] { color: #c9d1d9; font-size: 14px; }
.btn { background: #238636; color: #fff; border: none; border-radius: 6px; padding: 10px 24px; cursor: pointer; font-size: 14px; margin-top: 16px; }
.btn:hover { background: #2ea043; }
.success { background: #0d2314; border: 1px solid #238636; border-radius: 6px; padding: 14px; margin-top: 16px; }
.success p { color: #3fb950; font-size: 14px; margin-bottom: 6px; }
.success a { color: #58a6ff; font-size: 13px; word-break: break-all; }
.error-box { background: #2d1114; border: 1px solid #f85149; border-radius: 6px; padding: 14px; color: #f85149; font-size: 14px; margin-top: 16px; }
.back { color: #58a6ff; text-decoration: none; font-size: 13px; display: inline-block; margin-bottom: 24px; }
.info { background: #0e1925; border: 1px solid #1f3a5a; border-radius: 6px; padding: 14px; font-size: 13px; color: #79c0ff; margin-top: 24px; line-height: 1.7; }
.info code { background: #161b22; padding: 2px 6px; border-radius: 4px; font-size: 12px; color: #ff7b72; }
</style>
</head>
<body>
<div class="container">
  <a href="/" class="back">← Back to portal</a>
  <h2>Document Upload</h2>
  <p class="sub">Upload company documents for sharing. All file types accepted.</p>

  <form method="POST" enctype="multipart/form-data">
    <div class="upload-box">
      <p style="color:#8b949e; font-size:14px; margin-bottom:16px;">Select a file to upload</p>
      <input type="file" name="file" required>
      <br>
      <button type="submit" class="btn">Upload File</button>
    </div>
  </form>

  <?php if ($message === 'success'): ?>
  <div class="success">
    <p>✓ File uploaded successfully!</p>
    <p style="color:#8b949e; font-size:13px; margin-bottom:4px;">Accessible at:</p>
    <a href="<?php echo $uploaded_path; ?>" target="_blank">
      http://localhost<?php echo $uploaded_path; ?>
    </a>
  </div>
  <?php elseif ($message === 'error'): ?>
  <div class="error-box">Upload failed. Check permissions.</div>
  <?php endif; ?>

  <div class="info">
    <strong>Note:</strong> Uploaded files are stored in <code>/uploads/</code> and are directly accessible.<br>
    Supported formats: .pdf, .doc, .txt, .png, .jpg ... (no restrictions)
  </div>
</div>
</body>
</html>

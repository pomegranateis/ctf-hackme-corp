<?php
$company = "HackMe Corp";
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>HackMe Corp — Employee Portal</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: Arial, sans-serif; background: #0d1117; color: #c9d1d9; min-height: 100vh; }
header { background: #161b22; border-bottom: 1px solid #30363d; padding: 16px 32px; display: flex; align-items: center; gap: 12px; }
header .logo { width: 36px; height: 36px; background: #238636; border-radius: 6px; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 18px; color: #fff; }
header h1 { font-size: 20px; color: #e6edf3; }
.hero { padding: 60px 32px; text-align: center; }
.hero h2 { font-size: 36px; color: #e6edf3; margin-bottom: 12px; }
.hero p { font-size: 16px; color: #8b949e; max-width: 500px; margin: 0 auto 32px; line-height: 1.6; }
.btn-row { display: flex; gap: 12px; justify-content: center; flex-wrap: wrap; }
.btn { padding: 10px 24px; border-radius: 6px; text-decoration: none; font-size: 14px; font-weight: 500; cursor: pointer; border: none; }
.btn-green { background: #238636; color: #fff; }
.btn-green:hover { background: #2ea043; }
.btn-outline { background: transparent; color: #58a6ff; border: 1px solid #30363d; }
.btn-outline:hover { background: #161b22; }
.cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; padding: 0 32px 60px; max-width: 900px; margin: 0 auto; }
.card { background: #161b22; border: 1px solid #30363d; border-radius: 8px; padding: 20px; }
.card h3 { color: #58a6ff; font-size: 14px; margin-bottom: 8px; }
.card p { font-size: 13px; color: #8b949e; line-height: 1.5; }
footer { text-align: center; padding: 20px; font-size: 12px; color: #484f58; border-top: 1px solid #21262d; }
</style>
</head>
<body>

<header>
  <div class="logo">H</div>
  <h1>HackMe Corp</h1>
</header>

<div class="hero">
  <h2>Employee Portal</h2>
  <p>Internal company portal for HackMe Corp employees. Please login to access resources.</p>
  <div class="btn-row">
    <a href="/login.php" class="btn btn-green">Employee Login</a>
    <a href="/search.php" class="btn btn-outline">Search Staff</a>
    <a href="/upload.php" class="btn btn-outline">File Upload</a>
  </div>
</div>

<div class="cards">
  <div class="card">
    <h3>📋 Announcements</h3>
    <p>Q4 review meeting scheduled for Friday. Please submit your reports by Thursday EOD.</p>
  </div>
  <div class="card">
    <h3>📁 Document Library</h3>
    <p>Access shared company documents via the file upload portal.</p>
  </div>
  <div class="card">
    <h3>👥 Staff Directory</h3>
    <p>Search for employee information using the staff search tool.</p>
  </div>
  <div class="card">
    <h3>🔒 IT Support</h3>
    <p>Contact IT via SSH on port 22. Default credentials apply.</p>
  </div>
</div>

<footer>
  HackMe Corp Internal Portal &copy; 2024 | Server: Apache/2.4 | PHP/<?php echo phpversion(); ?>
</footer>

</body>
</html>

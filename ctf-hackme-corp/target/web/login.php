<?php
$message = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user = $_POST['username'] ?? '';
    $pass = $_POST['password'] ?? '';
    $conn = new mysqli("localhost", "root", "", "hackme");
    $sql  = "SELECT * FROM users WHERE username='$user' AND password='$pass'";
    $res  = $conn->query($sql);
    if ($res && $res->num_rows > 0) {
        $message = "Welcome back, " . htmlspecialchars($user) . "!";
    } else {
        $message = "error";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login — HackMe Corp</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: Arial, sans-serif; background: #0d1117; color: #c9d1d9; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
.card { background: #161b22; border: 1px solid #30363d; border-radius: 8px; padding: 32px; width: 100%; max-width: 360px; }
h2 { color: #e6edf3; text-align: center; margin-bottom: 24px; }
label { font-size: 13px; color: #8b949e; display: block; margin-bottom: 6px; }
input[type=text], input[type=password] { width: 100%; background: #0d1117; border: 1px solid #30363d; border-radius: 6px; padding: 10px 12px; color: #e6edf3; font-size: 14px; outline: none; margin-bottom: 14px; }
input:focus { border-color: #58a6ff; }
button { width: 100%; background: #238636; color: #fff; border: none; border-radius: 6px; padding: 10px; font-size: 14px; cursor: pointer; }
button:hover { background: #2ea043; }
.success { background: #0d2314; border: 1px solid #238636; border-radius: 6px; padding: 10px; color: #3fb950; font-size: 13px; text-align: center; margin-top: 14px; }
.error { background: #2d1114; border: 1px solid #f85149; border-radius: 6px; padding: 10px; color: #f85149; font-size: 13px; text-align: center; margin-top: 14px; }
.back { display: block; text-align: center; color: #58a6ff; text-decoration: none; font-size: 13px; margin-top: 16px; }
</style>
</head>
<body>
<div class="card">
  <h2>HackMe Corp Login</h2>
  <form method="POST">
    <label>Username</label>
    <input type="text" name="username" placeholder="Enter username" required>
    <label>Password</label>
    <input type="password" name="password" placeholder="Enter password" required>
    <button type="submit">Sign In</button>
  </form>
  <?php if ($message && $message !== 'error'): ?>
    <div class="success"><?php echo $message; ?></div>
  <?php elseif ($message === 'error'): ?>
    <div class="error">Invalid username or password.</div>
  <?php endif; ?>
  <a href="/" class="back">← Back to portal</a>
</div>
</body>
</html>

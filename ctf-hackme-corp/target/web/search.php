<?php
// =========================================================
// INTENTIONALLY VULNERABLE — CTF Challenge 4: SQL Injection
// DO NOT USE IN PRODUCTION
// =========================================================

$conn = new mysqli("localhost", "root", "", "hackme");
$results = [];
$query_shown = "";
$error = "";

if (isset($_GET['q']) && $_GET['q'] !== '') {
    $input = $_GET['q'];  // NO sanitisation — intentionally vulnerable

    $sql = "SELECT id, username, role FROM users WHERE username LIKE '%" . $input . "%'";
    $query_shown = $sql;

    $result = $conn->query($sql);
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $results[] = $row;
        }
    } else {
        $error = $conn->error;
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Staff Search — HackMe Corp</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: Arial, sans-serif; background: #0d1117; color: #c9d1d9; min-height: 100vh; padding: 40px 20px; }
.container { max-width: 700px; margin: 0 auto; }
h2 { color: #e6edf3; margin-bottom: 8px; }
p.sub { color: #8b949e; font-size: 14px; margin-bottom: 24px; }
.search-box { display: flex; gap: 10px; margin-bottom: 24px; }
input[type=text] { flex: 1; background: #161b22; border: 1px solid #30363d; border-radius: 6px; padding: 10px 14px; color: #e6edf3; font-size: 14px; outline: none; }
input[type=text]:focus { border-color: #58a6ff; }
button { background: #238636; color: #fff; border: none; border-radius: 6px; padding: 10px 20px; cursor: pointer; font-size: 14px; }
button:hover { background: #2ea043; }
.query-debug { background: #161b22; border: 1px solid #30363d; border-radius: 6px; padding: 12px; font-family: monospace; font-size: 12px; color: #8b949e; margin-bottom: 16px; word-break: break-all; }
.query-debug span { color: #ff7b72; }
table { width: 100%; border-collapse: collapse; }
th { background: #161b22; padding: 10px 14px; text-align: left; font-size: 13px; color: #8b949e; border-bottom: 1px solid #30363d; }
td { padding: 10px 14px; font-size: 13px; border-bottom: 1px solid #21262d; }
.role-admin { color: #f85149; font-weight: bold; }
.role-user  { color: #79c0ff; }
.error { background: #2d1114; border: 1px solid #f85149; border-radius: 6px; padding: 12px; color: #f85149; font-family: monospace; font-size: 12px; margin-bottom: 16px; }
.back { color: #58a6ff; text-decoration: none; font-size: 13px; display: inline-block; margin-bottom: 24px; }
.hint { background: #0e1925; border: 1px solid #1f3a5a; border-radius: 6px; padding: 12px; font-size: 13px; color: #79c0ff; margin-top: 24px; }
</style>
</head>
<body>
<div class="container">
  <a href="/" class="back">← Back to portal</a>
  <h2>Staff Directory Search</h2>
  <p class="sub">Search for employees by name.</p>

  <form method="GET">
    <div class="search-box">
      <input type="text" name="q" placeholder="Enter employee name..." value="<?php echo htmlspecialchars($_GET['q'] ?? ''); ?>">
      <button type="submit">Search</button>
    </div>
  </form>

  <?php if ($query_shown): ?>
  <div class="query-debug">
    SQL: <span><?php echo htmlspecialchars($query_shown); ?></span>
  </div>
  <?php endif; ?>

  <?php if ($error): ?>
  <div class="error">MySQL Error: <?php echo $error; ?></div>
  <?php endif; ?>

  <?php if (!empty($results)): ?>
  <table>
    <tr><th>ID</th><th>Username</th><th>Role</th></tr>
    <?php foreach ($results as $row): ?>
    <tr>
      <td><?php echo $row['id']; ?></td>
      <td><?php echo htmlspecialchars($row['username']); ?></td>
      <td><span class="role-<?php echo $row['role']; ?>"><?php echo $row['role']; ?></span></td>
    </tr>
    <?php endforeach; ?>
  </table>
  <?php elseif (isset($_GET['q'])): ?>
  <p style="color:#8b949e; font-size:14px;">No results found.</p>
  <?php endif; ?>

  <div class="hint">
    <strong>Hint:</strong> Try searching for: <code>admin</code>, or something more creative...
    <br>The query structure is: <code>SELECT ... WHERE username LIKE '%INPUT%'</code>
  </div>
</div>
</body>
</html>

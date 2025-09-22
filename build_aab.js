#!/usr/bin/env node

const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

function run(cmd) {
  try {
    console.log(`\n> ${cmd}`);
    execSync(cmd, { stdio: "inherit" });
  } catch (err) {
    console.error(`\nCommand failed: ${cmd}`);
    process.exit(1);
  }
}

// argument: major | minor | patch
const part = (process.argv[2] || "patch").toLowerCase();
if (!["major", "minor", "patch"].includes(part)) {
  console.error("Invalid argument. Use: major | minor | patch");
  process.exit(1);
}

const root = __dirname;
const pubspecPath = path.join(root, "pubspec.yaml");
if (!fs.existsSync(pubspecPath)) {
  console.error("pubspec.yaml not found in project root.");
  process.exit(1);
}

let pub = fs.readFileSync(pubspecPath, "utf8");

// match version: 1.2.3+4  OR version: "1.2.3+4"
const versionRegex = /^version:\s*["']?(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?["']?/m;
const m = pub.match(versionRegex);
if (!m) {
  console.error('Could not find "version:" in pubspec.yaml. Expected format: version: 1.0.0+1');
  process.exit(1);
}

let major = Number(m[1]), minor = Number(m[2]), patch = Number(m[3]);
let build = m[4] ? Number(m[4]) : 0;

// bump semantic version
if (part === "major") { major++; minor = 0; patch = 0; }
else if (part === "minor") { minor++; patch = 0; }
else { patch++; }

// always increment build number to ensure Google Play uniqueness
build = build + 1;

const newVersionString = `${major}.${minor}.${patch}+${build}`;

// backup pubspec
fs.copyFileSync(pubspecPath, `${pubspecPath}.bak.${Date.now()}`);

// replace version line
const newPub = pub.replace(versionRegex, `version: ${newVersionString}`);
fs.writeFileSync(pubspecPath, newPub, "utf8");

console.log(`\n✅ pubspec.yaml updated: ${m[0]}  ➜  version: ${newVersionString}`);

// Optionally update android/local.properties for consistency
const localPropsPath = path.join(root, "android", "local.properties");
try {
  if (fs.existsSync(localPropsPath)) {
    let lp = fs.readFileSync(localPropsPath, "utf8").split(/\r?\n/).filter(Boolean);

    // remove existing flutter.versionName / flutter.versionCode
    lp = lp.filter(l => !l.startsWith("flutter.versionName") && !l.startsWith("flutter.versionCode"));

    lp.push(`flutter.versionName=${major}.${minor}.${patch}`);
    lp.push(`flutter.versionCode=${build}`);

    fs.writeFileSync(localPropsPath, lp.join("\n") + "\n", "utf8");
    console.log(`✅ android/local.properties updated with flutter.versionName and flutter.versionCode`);
  } else {
    console.log(`ℹ️ android/local.properties not found — skipping local.properties update`);
  }
} catch (e) {
  console.warn("⚠️ Failed to update local.properties (non-fatal):", e.message);
}

// Build
console.log("\n🔧 Running flutter pub get...");
run("flutter pub get");

console.log(`\n🏗️ Building AAB with build-name=${major}.${minor}.${patch} and build-number=${build} ...`);
run(`flutter build appbundle --release --build-name=${major}.${minor}.${patch} --build-number=${build}`);

console.log("\n🎉 Build finished!");
console.log("AAB path: build/app/outputs/bundle/release/app-release.aab");
console.log(`Uploaded versionCode will be: ${build}  (versionName: ${major}.${minor}.${patch})`);

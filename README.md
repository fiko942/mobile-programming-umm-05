# High Sierra–styled Flutter App (Counter + About)

This Flutter app features a minimal, classic macOS High Sierra look and feel using Cupertino widgets. It includes two pages: Counter and About, with a bottom navigation bar, real‑time form validation, and a developer card linking to a portfolio.

Built to fulfill Module 1 of the Mobile Programming course at Universitas Muhammadiyah Malang.

## Features

- Classic macOS High Sierra theme
	- Accent blue (#007AFF), light window greys, hairline separators
	- Cupertino components for a native mac-like experience
- Two pages with bottom tabs
	- Counter: large count display, filled increment button, reset
	- About: short description, author card (avatar, name, email, website), contact form (email, sender name, message)
- Contact form
	- Real‑time field validation with inline messages
	- Submit disabled until all checks pass
	- Simulated submit with 2s loading and success alert
- Author card
	- Avatar URL: https://avatars.githubusercontent.com/u/84434815?v=4
	- Name: Wiji Fiko Teren
	- Email: tobellord@gmail.com
	- Website (tap to open): https://wijifikoteren.streampeg.com

## Project structure

- `lib/main.dart` — App entry, Cupertino theme, tab scaffold
- `lib/pages/counter_page.dart` — Counter screen
- `lib/pages/about_page.dart` — About screen + contact form + author card
- `lib/widgets/hairline_divider.dart` — Shared macOS-like thin separator
- `test/widget_test.dart` — Widget and navigation performance tests

## Development setup

Prerequisites
- Flutter SDK (stable). Recommended: Flutter 3.24+ (Dart SDK 3.9+)
- macOS (for macOS/iOS builds), Xcode, and CocoaPods (`brew install cocoapods`)
- Android Studio + Android SDK (for Android builds)
- A device/simulator/emulator or Chrome (for Web)

Install dependencies

```bash
flutter pub get
```

Run the app

```bash
# Choose a target device: macOS, iOS Simulator, Android emulator, or Chrome
flutter devices
flutter run -d macos   # or -d ios / -d android / -d chrome
```

Run tests

```bash
flutter test
```

## Latest test report (before last commit)

Widget and navigation tests include soft performance checks and print timings. Example from the latest run:

```
Initial widget build: 135 ms
Single increment interaction: 34 ms
Navigation: total=161 ms, avg per loop=31 ms, samples=[88, 20, 18, 17, 16]
Counter: total=42 ms, avg per increment=2.1 ms
```

Notes
- Timings are from the test environment and are best used for relative comparison between commits rather than as absolute performance numbers.

## Design rationale

- Why macOS High Sierra style?
	- Simple, clean, and familiar visual language that emphasizes clarity
	- Light grey window surfaces + hairline separators provide subtle structure
	- Accent blue (#007AFF) gives clear affordances for primary actions
- Why Cupertino widgets?
	- Native mac/iOS feel, consistent typography and paddings out of the box
	- Cross‑platform: looks elegant on Android/Web too while retaining the style goal
- Layout choices
	- Bottom tab bar for two straightforward pages (Counter, About)
	- Large number for Counter to focus on the primary data
	- Filled primary button (blue) and subtle text button (Reset) to mirror macOS patterns
	- Real‑time form validation for better usability and immediate feedback

## Author

<table>
	<tr>
		<td width="120" valign="top">
			<img src="https://avatars.githubusercontent.com/u/84434815?v=4" alt="Wiji Fiko Teren" width="110" style="border-radius:12px; object-fit:cover;" />
		</td>
		<td valign="top">
			<strong>Name:</strong> Wiji Fiko Teren<br/>
			<strong>University:</strong> Universitas Muhammadiyah Malang<br/>
			<strong>Email:</strong> <a href="mailto:tobellord@gmail.com">tobellord@gmail.com</a><br/>
			<strong>Website:</strong> <a href="https://wijifikoteren.streampeg.com" target="_blank">https://wijifikoteren.streampeg.com</a>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<sub>This project was created to fulfill Module 1 of the Mobile Programming course, with a focus on a clean, classic macOS High Sierra design.</sub>
		</td>
	</tr>
  
</table>

## Notes & constraints

- The contact form is fully local with simulated submission (no backend). It displays a success alert after a 2‑second loading animation.
- External links (portfolio) use `url_launcher` and open in the default browser.

## License

This repository currently has no explicit license. Add one if you plan to distribute or open‑source it.

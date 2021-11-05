# Localizations Comments Checker

It's really easy to overlook and don't add comment for localization in interface file (.storyboard or .xib). This command line utility recursively scans project folders and reports localizations that have no comments.

## Scan project
Compiled binary (Intel) is in the build folder.
If necessary it's easy to create one for ARM using Archive / Distribute in Xcode.

Usage:

```./localizationsCommentsChecker <path to project's folder>```

The first and only required parameter is the path to project's folder.

Output lists files with missing comments:
```
Scan localization comments in interface files started...

BMCollectionHeaderView.strings
No comment for: "aYC-Oy-O09.normalTitle" = "Edit";
No comment for: "zbQ-gz-FTW.text" = "Change";

BMRatePOIBottomSheetViewController.strings
No comment for: "47e-Cn-dfA.accessibilityLabel" = "View and Add Report Comments";
No comment for: "b7a-ke-hjC.accessibilityLabel" = "Confirm Report";

```

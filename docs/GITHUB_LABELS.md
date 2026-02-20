# 🏷️ GitHub Labels Guide

Labels help categorize and prioritize issues and pull requests.

This project uses a structured labeling system organized by category.

## Label Categories

### Type Labels (What kind of issue)

| Label         | Color  | Hex     | Description                     |
| ------------- | ------ | ------- | ------------------------------- |
| bug           | Red    | #d73a4a | Something isn't working         |
| feature       | Cyan   | #a2eeef | New feature request             |
| enhancement   | Blue   | #84b6eb | Improvement to existing feature |
| documentation | Purple | #0075ca | Documentation updates           |
| question      | Pink   | #d876e3 | Questions or discussions        |
| task          | Yellow | #fbca04 | General task or todo            |

### Status Labels (Current state)

| Label                 | Color  | Hex     | Description                             |
| --------------------- | ------ | ------- | --------------------------------------- |
| needs-triage          | Orange | #e4e669 | Needs initial review and categorization |
| needs-attention       | Red    | #b60205 | Requires immediate attention            |
| needs-author-feedback | Yellow | #fbca04 | Waiting for response from author        |
| in-progress           | Green  | #0e8a16 | Currently being worked on               |
| blocked               | Red    | #b60205 | Blocked by another issue or dependency  |
| ready-for-review      | Blue   | #0075ca | Ready for code review                   |

### Priority Labels (How urgent)

| Label             | Color    | Hex     | Description           |
| ----------------- | -------- | ------- | --------------------- |
| priority-critical | Dark Red | #b60205 | Must fix immediately  |
| priority-high     | Red      | #d73a4a | Should fix soon       |
| priority-medium   | Orange   | #e99695 | Normal priority       |
| priority-low      | Gray     | #c5def5 | Nice to have, no rush |

### Area Labels (Which part of the project)

| Label       | Color     | Hex     | Description            |
| ----------- | --------- | ------- | ---------------------- |
| area-api    | Dark Blue | #1d76db | API related            |
| area-cli    | Dark Blue | #1d76db | CLI related            |
| area-tests  | Dark Blue | #1d76db | Test related           |
| area-ci     | Dark Blue | #1d76db | CI/CD pipeline related |
| area-docs   | Dark Blue | #1d76db | Documentation related  |
| area-config | Dark Blue | #1d76db | Configuration related  |

### Special Labels

| Label            | Color  | Hex     | Description                      |
| ---------------- | ------ | ------- | -------------------------------- |
| help-wanted      | Green  | #008672 | Open for community contributions |
| good-first-issue | Purple | #7057ff | Good for newcomers               |
| duplicate        | Gray   | #cfd3d7 | Already exists                   |
| wontfix          | White  | #ffffff | Will not be addressed            |
| invalid          | Gray   | #e4e669 | Not a valid issue                |

## How To Apply Labels

### On an Issue

1. Open the issue
2. Click "Labels" in the right sidebar
3. Select one or more labels
4. Common combinations:
    - bug + priority-high + area-api
    - feature + priority-medium + help-wanted
    - documentation + good-first-issue

### On a Pull Request

1. Open the PR
2. Click "Labels" in the right sidebar
3. Common combinations:
    - bug + ready-for-review
    - feature + in-progress
    - documentation + ready-for-review

## Label Naming Convention

    category-name

    Examples:
    priority-high
    area-api
    needs-triage

- All lowercase
- Hyphens for spaces
- Category prefix for grouping

## Auto-Create Labels

Use the script in scripts/create-labels.sh to automatically set up all labels:

    bash scripts/create-labels.sh

See scripts/README.md for details.

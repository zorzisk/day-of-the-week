# day-of-the-week

# Day of the Week Variable

A lightweight, zero-dependency variable for Google Tag Manager that returns the current day of the week. It uses native GTM APIs (`getTimestampMillis`) to ensure full compliance with GTM Sandbox security without requiring any custom permissions.

## Features
* **Multiple Formats:** Short Name (Mon), Long Name (Monday), ISO Number (1-7), or US Number (1-7).
* **Timezone Support:** Built-in offset field to align the day with your business hours/server time, regardless of the user's local time.
* **Secure:** No access to global scope or sensitive APIs required.

## Configuration

### 1. Output Format
Select how you want the day to be formatted:
* **Short Name:** Sun, Mon, Tue...
* **Long Name:** Sunday, Monday, Tuesday...
* **Number (ISO 8601):** Monday = 1 ... Sunday = 7
* **Number (US):** Sunday = 1 ... Saturday = 7

### 2. Timezone Offset (Hours)
Enter a number to adjust the time relative to UTC/GMT.
* **0:** UTC (Universal Time).
* **-5:** Eastern Standard Time (US).
* **+1:** Central European Time.
* *Note: If left empty, it defaults to 0 (UTC).*

## Example Use Cases
* Triggering a "Chat Widget" only on weekdays (Mon-Fri).
* Showing a "Weekend Sale" banner on Saturday and Sunday.
* Sending the day of the week as a Custom Dimension to Google Analytics 4.

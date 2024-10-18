# Codker

**Codker** is a Bash script designed to check the HTTP status codes of a list of domains. This tool helps users quickly determine the availability of websites by checking their response codes, providing insights into which domains are up or down.

## Features

- **HTTP Status Code Checking**: Easily checks the HTTP status codes for a list of domains to determine if they are reachable.
- **Percentage Reporting**: Displays the percentage of up and down domains during the scanning process.
- **Result Output**: Saves the results to a specified file for easy review and record-keeping.
- **User-Friendly Interface**: Provides a colorful banner and a clear usage menu for better user experience.

## Installation

Follow these steps to install the tool:

1. Clone the repository:
   ```bash
   git clone https://github.com/HBlackGhost/codker.git
   ```
2. Navigate into the project directory:
   ```bash
   cd codker
   ```
3. Make the script executable:
   ```bash
   chmod +x codker.sh
   ```

## Usage

To use the tool, run the following command:

```bash
./codker.sh -l domain.txt -o results.txt
```

### Options

- `-h`    Show help message and exit.
- `-l`    Specify the file containing the list of URLs to check (one URL per line).
- `-o`    Specify the output file for results (this option requires the `-l` option).

### Notes

- Ensure that the file specified with the `-l` option contains one URL per line in the format 'example.com' (without 'https://').
- The `-o` option is dependent on the `-l` option being specified first.

## Example

```bash
./codker.sh -l domain.txt -o results.txt
```

This command will check the HTTP status codes for the domains listed in `domain.txt` and save the results in `results.txt`.

## Results Interpretation

After running the script, you will see a summary of the results, including:
- **Up Domains**: The number of domains that returned a status code indicating they are reachable (200-399).
- **Down Domains**: The number of domains that returned a status code indicating they are not reachable (404, 500, etc.).
- **Total Domains Checked**: The total number of domains processed.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

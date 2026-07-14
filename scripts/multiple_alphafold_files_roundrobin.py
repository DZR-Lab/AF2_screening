#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Mar  9 17:28:43 2025

@author: annabrogan

Updated on Tue Jul 14 by James Warner
"""

import csv
import os

def split_csv(file_path, output_dir, num_parts=16):
    """
    Splits a CSV file into parts by cycling through each row, ensuring each file gets rows in sequence.

    :param file_path: Path to the input CSV file.
    :param output_dir: Directory to save the output files.
    :param num_parts: Number of parts to split the file into (default is 16).
    """
    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)

    # Read the input CSV file
    with open(file_path, 'r', newline='', encoding='utf-8') as input_file:
        reader = csv.reader(input_file)
        header = next(reader)
        rows = list(reader)

    # Create file writers for each part
    part_files = []
    for part in range(num_parts):
        part_file_name = os.path.join(output_dir, f'part_{part + 1}.csv')
        part_file = open(part_file_name, 'w', newline='', encoding='utf-8')
        writer = csv.writer(part_file)
        writer.writerow(header)
        part_files.append((part_file, writer))

    # Distribute rows in a round-robin fashion
    for index, row in enumerate(rows):
        part_index = index % num_parts
        part_files[part_index][1].writerow(row)

    # Close all part files
    for part_file, _ in part_files:
        part_file.close()

    print(f"CSV file split into {num_parts} parts in the directory: {output_dir}")

# Example usage
# Replace 'input.csv' with the path to your CSV file and 'output_parts' with your desired output directory
split_csv('input/search_input.csv', 'input/split_inputs')

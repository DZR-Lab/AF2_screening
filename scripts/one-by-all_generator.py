#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar 17 11:55:53 2026

@author: james_warner
"""

### SCRIPT TO GENERATE ONE-BY-ALL INPUT FILES FOR AF2-MULTIMER SCREENING ON O2

import csv


#Read input FASTA protein name (or Uniprot ID) and sequence
with open('input/query.fa', 'r') as f:
    one_id = f.readline().strip('\n').strip('>')
    one_sequence = f.readline().strip('\n')
    one_length = len(one_sequence)


#initialize output
output = []

#open uniprot reference proteome, pull info from each row (= protein), and create one-by-all output info as part of list
with open('proteome/<YOUR_PROTEOME_FILE_HERE.tsv>', newline='', encoding='utf-8') as f:
    reader = csv.DictReader(f, delimiter='\t')
    for row in reader:
        query_id = row["Entry"]
        query_sequence = row["Sequence"]
        query_length = int(row["Length"])
        output.append([one_id+'_'+query_id, one_id+';'+query_id, one_sequence+':'+query_sequence, one_length+query_length])
        

#sort output by length
output.sort(key=lambda x: int(x[3]))

#add header
output = [['id','uniprot_ids','sequence','length']]+output

#write output as csv
with open('input/search_input.csv', 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    csv_writer.writerows(output)



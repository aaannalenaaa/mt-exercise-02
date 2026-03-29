import csv
import glob
import os

files = sorted(glob.glob('logs/dropout_*.csv'))

results = {}
for f in files:
    label = f'dropout_{os.path.basename(f).replace("dropout_", "").replace(".csv", "")}'
    with open(f) as fh:
        reader = csv.DictReader(fh)
        for row in reader:
            if row['epoch'] == 'test':
                continue
            epoch = int(row['epoch'])
            if epoch not in results:
                results[epoch] = {}
            results[epoch][label] = row['valid_ppl']

dropouts = [os.path.basename(f).replace('dropout_', '').replace('.csv', '') for f in files]
headers = ['epoch'] + [f'dropout_{d}' for d in dropouts]

with open('logs/combined_valid_ppl.csv', 'w', newline='') as out:
    writer = csv.writer(out)
    writer.writerow(headers)
    for epoch in sorted(results.keys()):
        row = [epoch] + [results[epoch].get(f'dropout_{d}', '') for d in dropouts]
        writer.writerow(row)

print("Saved to logs/combined_valid_ppl.csv :)")

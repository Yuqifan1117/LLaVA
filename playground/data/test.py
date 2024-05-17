import json

data = json.load(open('LLaVA/playground/data/llava_v1_5_mix_coco.json'))
print(len(data))
print(data[0])

valid_data = []
for d in data:
    if 'image' in d and 'coco/train2017' in d['image'] and len(d['conversations']) == 2:
        valid_data.append(d)
print(len(valid_data))
json.dump(valid_data, open('LLaVA/playground/data/llava_v1_5_mix_coco_single_dialog.json', 'w'))
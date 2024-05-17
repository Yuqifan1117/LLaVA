#!/bin/bash
# PYTHONPATH='./' bash scripts/v1_5/finetune_lora_stage2_7b.sh
export CUDA_VISIBLE_DEVICES='4'
deepspeed --master_port 29501 llava/train/train_mem.py \
    --lora_enable True --lora_r 128 --lora_alpha 256 --mm_projector_lr 2e-5 \
    --deepspeed ./scripts/zero3.json \
    --model_name_or_path /home1/yqf/Annotation-anything-pipeline/LLM_models/vicuna-7b-v1.5 \
    --version v1 \
    --data_path ./playground/data/llava_v1_5_mix_coco_single_dialog.json \
    --image_folder /home1/yqf/datasets \
    --vision_tower openai/clip-vit-large-patch14-336 \
    --pretrain_mm_mlp_adapter /home1/yqf/Annotation-anything-pipeline/LLM_models/llava-v1.5-vicuna7b-v1.5-projector/mm_projector.bin \
    --mm_projector_type mlp2x_gelu \
    --mm_vision_select_layer -2 \
    --mm_use_im_start_end False \
    --mm_use_im_patch_token False \
    --image_aspect_ratio pad \
    --group_by_modality_length True \
    --bf16 True \
    --output_dir ./checkpoints/llava-v1.5-7b-lora \
    --num_train_epochs 1 \
    --per_device_train_batch_size 1 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 16 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 50000 \
    --save_total_limit 1 \
    --learning_rate 2e-4 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --tf32 True \
    --model_max_length 2048 \
    --gradient_checkpointing True \
    --dataloader_num_workers 4 \
    --lazy_preprocess True \
    # --report_to wandb

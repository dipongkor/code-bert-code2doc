FROM python:3.7

RUN pip install torch==1.5.0 transformers>=2.5.0

# Copy data and code

COPY code .
COPY data ./data
COPY model ./model
COPY evaluator ./evaluator

RUN [ "python", "run.py", "--do_train", "--do_eval", "--model_type=roberta", \
        "--model_name_or_path=microsoft/codebert-base", \
        "--train_filename=./data/java/train.jsonl", \
        "--dev_filename=./data/java/valid.jsonl", \
        "--output_dir=./model/java", \
        "--max_source_length=256", \
        "--max_target_length=128" , \ 
        "--beam_size=10", \
        "--train_batch_size=2", \
        "--eval_batch_size=2", \
        "--learning_rate=5e-5", \
        "--num_train_epochs=2" ]


CMD [ "python", "./evaluator/evaluator.py", "./model/java/test_1.gold < ./model/java/test_1.output"]
#https://github.com/microsoft/CodeXGLUE/tree/main/Code-Text/code-to-text
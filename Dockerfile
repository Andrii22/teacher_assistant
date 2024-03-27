FROM python:3.10-slim

WORKDIR /root/teacher_assistant.v2

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    tk-dev \
    libffi-dev \
    libssl-dev \
    pkg-config \
    libmariadb-dev-compat

COPY requirements.txt .

COPY requirements2.txt .

RUN pip install --upgrade pip && \
    pip install --upgrade setuptools &&\   
    pip install flask &&\
    pip install flask_sqlalchemy &&\
    pip install g4f &&\
    pip install langdetect &&\
    pip install ttkthemes &&\
    pip install pyvbox &&\
    pip install mysqlclient &&\
    pip install mysql &&\
    pip install --no-cache-dir -r requirements.txt &&\
    pip install --no-cache-dir -r requirements2.txt

COPY . .

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "run:run.py"]

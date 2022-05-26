FROM python:3.7-slim
RUN mkdir /app
COPY requirements.txt /app
WORKDIR /app
RUN pip install -r requirements.txt
COPY . /app
ENTRYPOINT ["python", "main.py"]
EXPOSE 5000

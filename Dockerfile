FROM gordonwatts/rucion2n-for-xcache:1.0.1

RUN yum -y install python36 python36-pip wget

# Get everything installed
COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY tools/* ./

ENV PYTHONUNBUFFERED=1

ENTRYPOINT [ "/bin/bash", "start.sh" ]
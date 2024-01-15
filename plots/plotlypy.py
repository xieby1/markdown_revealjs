#!/usr/bin/env python3
from pathlib import Path
import plotly.graph_objects as go

fig = go.Figure(
    data = [
        go.Bar(x=[1,2,3,4], y=[1,3,1,4])
    ],
    layout=go.Layout(
        title=go.layout.Title(text="A Fig by a graph_objects")
    ),
)

# https://stackoverflow.com/questions/29968152/setting-background-color-to-transparent-in-plotly-plots
fig.update_layout(
    template="plotly_white",
    paper_bgcolor="rgba(0,0,0,0)",
    plot_bgcolor="rgba(0,0,0,0)",
)
fig.write_html(Path(__file__).with_suffix(".html"),
    include_plotlyjs="https://cdn.bootcdn.net/ajax/libs/plotly.js/2.25.2/plotly.min.js",
    full_html=False,
)
